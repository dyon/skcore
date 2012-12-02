#include "ScriptPCH.h"
#include "blackrock_spire.h"

class npc_bs_cria : public CreatureScript
{
    public:
        npc_bs_cria() : CreatureScript("npc_bs_cria") { }

        struct npc_bs_criaAI : public ScriptedAI
        {
            npc_bs_criaAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = me->GetInstanceScript();
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                DoMeleeAttackIfReady();
            }

            void JustDied(Unit* /*who*/)
            {
                if(instance)
                    instance->SetData(DATA_LEROY, SPECIAL);
            }

        private:
            InstanceScript* instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_bs_criaAI(creature);
        }
};

void AddSC_blackrock_spire()
{
    new npc_bs_cria();
}