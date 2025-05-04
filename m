Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F27CC369DC
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 May 2025 21:23:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FEFD4025D;
	Sun,  4 May 2025 23:23:06 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 1459440156
 for <dev@dpdk.org>; Sun,  4 May 2025 23:23:04 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so2950583a91.3
 for <dev@dpdk.org>; Sun, 04 May 2025 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1746393783; x=1746998583; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dELoLg5SK581ypGkDLnKRAPLEIxb27qCQUBYCvw/GfM=;
 b=Bc0Mbomr0VIe4BwOyJPUmyiKinoMUxufhrAF8v4uGh4UuHMi6Ou+dBw9NMDOK20KQ/
 bV4vq5dApRGBkEO/nPnp4UXJmuaeP4DZRGaPCqsUYua7VQs3acAEsTlA72Gxr/PpCsK9
 UedrQ2bnOb2VmBmtnUtXEP2b2TqRX/a6ERqMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393783; x=1746998583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dELoLg5SK581ypGkDLnKRAPLEIxb27qCQUBYCvw/GfM=;
 b=A/2TUbgjzl9QnX2ZO4Xhl5s2t7vnVrMuoQd6bWJrlR2Jyu23X3iFHVbBqwwdB1UKqD
 jDtuYnDpZNfAG3vQubd8G/1sEvNhSOjJcdYv0asGCcfnXpuhG4/3fl416w0xVRWSpPW9
 jeDnJn+jIb626CsjF45yGx+NCaByxJEVF/sskXN9sWhVLZBblsAnruPOe2OyeN02uyXN
 TN3bzoW8dAuDHUQibjGKxOkd8nNN1m4iRBmojWcnCabT5hEz+YN4VZstrJmhJgvqyo9d
 7JGI8er9+oKOl/qDx+mD1VScGpBLQFU5SrpbptyFsZi3R2SrnTr1u9fRdv1eYgbok0Jy
 ARfQ==
X-Gm-Message-State: AOJu0Yy8HcYc+o5gEnmTCxBlB6yPumLWfb+YIpdLBADBmwyycWXT2JGG
 Xtk/TfFNNv9HWfHJDQ4PrbO7nrWHuJs5sJeN8sHb1R+BZB7u2tpSBwaMxKBoalezkPDJe5hMD90
 ZhG6RuuokflZAL0xczOybYkoZ0SSJZuNBu5D7Kg==
X-Gm-Gg: ASbGncvEBuBdE7a1TG8oyyxb3UZDDRTIWRcfi72mEKtBQHeu93NlVVzX56WSwfbNgQt
 g+At9Lfsg6lkqk/ejS95OvYDpeYFyf7gUTb4vfiFFutN5Fzuk7AOftxIPkEYxIFN7tCobreVtoo
 yjbhwKIhSd5VOTNgomyequV2GCwHphKNvyir0/rQvGXGfUUUJpYWWE5u0=
X-Google-Smtp-Source: AGHT+IEUR1EDXxniSQEqGMkcmfyujEAF2z/85Jgtvg8zhNN1xVmQ58sPteSYah2e6uLRLqSbIxQMDK0+XCcuXslUZY8=
X-Received: by 2002:a17:90a:da85:b0:2fa:f8d:65de with SMTP id
 98e67ed59e1d1-30a61a2c41cmr5750068a91.22.1746393783065; Sun, 04 May 2025
 14:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250504052350.91160-1-getelson@nvidia.com>
In-Reply-To: <20250504052350.91160-1-getelson@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 4 May 2025 17:18:30 -0400
X-Gm-Features: ATxdqUFNHDK8s1rKw1SBZmdIRY4yHfzRFXeB4TU8MuY0NKaiYUiyHnmeA31gHEc
Message-ID: <CAJvnSUC9JTLH-YTdEVFXs9px53uYkybYbNy_fbxzRVe88bvGLw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix support for meter flow action in HWS
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Content-Type: multipart/alternative; boundary="00000000000013f26a063455fd3c"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--00000000000013f26a063455fd3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard the Community Lab DTS failure just reported on this
patchseries. I need to reconfigure the testbed and rerun the test.

On Sun, May 4, 2025 at 1:24=E2=80=AFAM Gregory Etelson <getelson@nvidia.com=
> wrote:

> METER flow action is not supported in MLX5 HWS mode.
> Application must use METER_MARK flow action.
>
> The patch removes METER action from HWS code.
>
> Fixes: 48fbb0e93d06 ("net/mlx5: support flow meter mark indirect action
> with HWS")
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_flow_hw.c    |  85 -----
>  drivers/net/mlx5/mlx5_flow_meter.c | 552 -----------------------------
>  2 files changed, 637 deletions(-)
>
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> b/drivers/net/mlx5/mlx5_flow_hw.c
> index 20d38ce414..1f192c1937 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -1784,35 +1784,6 @@ flow_hw_represented_port_compile(struct rte_eth_de=
v
> *dev,
>         return 0;
>  }
>
> -static __rte_always_inline int
> -flow_hw_meter_compile(struct rte_eth_dev *dev,
> -                     const struct mlx5_flow_template_table_cfg *cfg,
> -                     uint16_t aso_mtr_pos,
> -                     uint16_t jump_pos,
> -                     const struct rte_flow_action *action,
> -                     struct mlx5_hw_actions *acts,
> -                     struct rte_flow_error *error)
> -{
> -       struct mlx5_priv *priv =3D dev->data->dev_private;
> -       struct mlx5_aso_mtr *aso_mtr;
> -       const struct rte_flow_action_meter *meter =3D action->conf;
> -       uint32_t group =3D cfg->attr.flow_attr.group;
> -
> -       aso_mtr =3D mlx5_aso_meter_by_idx(priv, meter->mtr_id);
> -       acts->rule_acts[aso_mtr_pos].action =3D priv->mtr_bulk.action;
> -       acts->rule_acts[aso_mtr_pos].aso_meter.offset =3D aso_mtr->offset=
;
> -       acts->jump =3D flow_hw_jump_action_register
> -               (dev, cfg, aso_mtr->fm.group, error);
> -       if (!acts->jump)
> -               return -ENOMEM;
> -       acts->rule_acts[jump_pos].action =3D (!!group) ?
> -                                   acts->jump->hws_action :
> -                                   acts->jump->root_action;
> -       if (mlx5_aso_mtr_wait(priv, aso_mtr, true))
> -               return -ENOMEM;
> -       return 0;
> -}
> -
>  static __rte_always_inline int
>  flow_hw_cnt_compile(struct rte_eth_dev *dev, uint32_t  start_pos,
>                       struct mlx5_hw_actions *acts)
> @@ -2534,7 +2505,6 @@ __flow_hw_translate_actions_template(struct
> rte_eth_dev *dev,
>         bool reformat_used =3D false;
>         bool recom_used =3D false;
>         unsigned int of_vlan_offset;
> -       uint16_t jump_pos;
>         uint32_t ct_idx;
>         int ret, err;
>         uint32_t target_grp =3D 0;
> @@ -2802,27 +2772,6 @@ __flow_hw_translate_actions_template(struct
> rte_eth_dev *dev,
>                                          masks, acts, src_pos, dr_pos,
> &sub_error))
>                                 goto err;
>                         break;
> -               case RTE_FLOW_ACTION_TYPE_METER:
> -                       /*
> -                        * METER action is compiled to 2 DR actions -
> ASO_METER and FT.
> -                        * Calculated DR offset is stored only for
> ASO_METER and FT
> -                        * is assumed to be the next action.
> -                        */
> -                       jump_pos =3D dr_pos + 1;
> -                       if (actions->conf && masks->conf &&
> -                           ((const struct rte_flow_action_meter *)
> -                            masks->conf)->mtr_id) {
> -                               err =3D flow_hw_meter_compile(dev, cfg,
> -                                                           dr_pos,
> jump_pos, actions, acts,
> -                                                           &sub_error);
> -                               if (err)
> -                                       goto err;
> -                       } else if (__flow_hw_act_data_general_append(priv=
,
> acts,
> -
> actions->type,
> -
> src_pos,
> -
> dr_pos))
> -                               goto err;
> -                       break;
>                 case RTE_FLOW_ACTION_TYPE_AGE:
>                         ret =3D flow_hw_translate_group(dev, cfg,
> attr->group,
>                                                 &target_grp, &sub_error);
> @@ -3510,7 +3459,6 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
>         const struct rte_flow_action_ipv6_ext_push *ipv6_push;
>         const struct rte_flow_item *enc_item =3D NULL;
>         const struct rte_flow_action_ethdev *port_action =3D NULL;
> -       const struct rte_flow_action_meter *meter =3D NULL;
>         const struct rte_flow_action_age *age =3D NULL;
>         const struct rte_flow_action_nat64 *nat64_c =3D NULL;
>         struct rte_flow_attr attr =3D {
> @@ -3683,28 +3631,6 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
>                                                 rule_acts +
> act_data->action_dst,
>                                                 act_data->shared_meter.id
> );
>                         break;
> -               case RTE_FLOW_ACTION_TYPE_METER:
> -                       meter =3D action->conf;
> -                       mtr_id =3D meter->mtr_id;
> -                       aso_mtr =3D mlx5_aso_meter_by_idx(priv, mtr_id);
> -                       rule_acts[act_data->action_dst].action =3D
> -                               priv->mtr_bulk.action;
> -                       rule_acts[act_data->action_dst].aso_meter.offset =
=3D
> -
>  aso_mtr->offset;
> -                       jump =3D flow_hw_jump_action_register
> -                               (dev, &table->cfg, aso_mtr->fm.group,
> NULL);
> -                       if (!jump)
> -                               goto error;
> -                       MLX5_ASSERT
> -                               (!rule_acts[act_data->action_dst +
> 1].action);
> -                       rule_acts[act_data->action_dst + 1].action =3D
> -                                       (!!attr.group) ? jump->hws_action=
 :
> -                                                        jump->root_actio=
n;
> -                       flow->jump =3D jump;
> -                       flow->flags |=3D MLX5_FLOW_HW_FLOW_FLAG_FATE_JUMP=
;
> -                       if (mlx5_aso_mtr_wait(priv, aso_mtr, true))
> -                               goto error;
> -                       break;
>                 case RTE_FLOW_ACTION_TYPE_AGE:
>                         aux =3D mlx5_flow_hw_aux(dev->data->port_id, flow=
);
>                         age =3D action->conf;
> @@ -7334,10 +7260,6 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev
> *dev,
>                         }
>                         action_flags |=3D
> MLX5_FLOW_ACTION_IPV6_ROUTING_REMOVE;
>                         break;
> -               case RTE_FLOW_ACTION_TYPE_METER:
> -                       /* TODO: Validation logic */
> -                       action_flags |=3D MLX5_FLOW_ACTION_METER;
> -                       break;
>                 case RTE_FLOW_ACTION_TYPE_METER_MARK:
>                         ret =3D flow_hw_validate_action_meter_mark(dev,
> action, false, error);
>                         if (ret < 0)
> @@ -7665,13 +7587,6 @@ flow_hw_parse_flow_actions_to_dr_actions(struct
> rte_eth_dev *dev,
>                                 action_types[mhdr_off] =3D type;
>                         }
>                         break;
> -               case RTE_FLOW_ACTION_TYPE_METER:
> -                       at->dr_off[i] =3D curr_off;
> -                       action_types[curr_off++] =3D
> MLX5DR_ACTION_TYP_ASO_METER;
> -                       if (curr_off >=3D MLX5_HW_MAX_ACTS)
> -                               goto err_actions_num;
> -                       action_types[curr_off++] =3D MLX5DR_ACTION_TYP_TB=
L;
> -                       break;
>                 case RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN:
>                         type =3D
> mlx5_hw_dr_action_types[at->actions[i].type];
>                         at->dr_off[i] =3D curr_off;
> diff --git a/drivers/net/mlx5/mlx5_flow_meter.c
> b/drivers/net/mlx5/mlx5_flow_meter.c
> index dab3c4bf77..cd6a804593 100644
> --- a/drivers/net/mlx5/mlx5_flow_meter.c
> +++ b/drivers/net/mlx5/mlx5_flow_meter.c
> @@ -1166,49 +1166,6 @@ mlx5_flow_meter_policy_validate(struct rte_eth_dev
> *dev,
>         return 0;
>  }
>
> -#if defined(HAVE_MLX5_HWS_SUPPORT)
> -/**
> - * Callback to check MTR policy action validate for HWS
> - *
> - * @param[in] dev
> - *   Pointer to Ethernet device.
> - * @param[in] actions
> - *   Pointer to meter policy action detail.
> - * @param[out] error
> - *   Pointer to the error structure.
> - *
> - * @return
> - *   0 on success, a negative errno value otherwise and rte_errno is set=
.
> - */
> -static int
> -mlx5_flow_meter_policy_hws_validate(struct rte_eth_dev *dev,
> -       struct rte_mtr_meter_policy_params *policy,
> -       struct rte_mtr_error *error)
> -{
> -       struct mlx5_priv *priv =3D dev->data->dev_private;
> -       const struct rte_flow_actions_template_attr attr =3D {
> -               .transfer =3D priv->sh->config.dv_esw_en ? 1 : 0 };
> -       int ret;
> -       int i;
> -
> -       if (mlx5_hws_active(dev) && !mlx5_hw_ctx_validate(dev, NULL))
> -               return -rte_mtr_error_set(error, EINVAL,
> -                                         RTE_MTR_ERROR_TYPE_UNSPECIFIED,
> NULL,
> -                                         "non-template flow engine was
> not configured");
> -       if (!priv->mtr_en || !priv->sh->meter_aso_en)
> -               return -rte_mtr_error_set(error, ENOTSUP,
> -                               RTE_MTR_ERROR_TYPE_METER_POLICY,
> -                               NULL, "meter policy unsupported.");
> -       for (i =3D 0; i < RTE_COLORS; i++) {
> -               ret =3D mlx5_flow_actions_validate(dev, &attr,
> policy->actions[i],
> -                                                policy->actions[i], NULL=
);
> -               if (ret)
> -                       return ret;
> -       }
> -       return 0;
> -}
> -#endif
> -
>  static int
>  __mlx5_flow_meter_policy_delete(struct rte_eth_dev *dev,
>                         uint32_t policy_id,
> @@ -1540,334 +1497,6 @@ mlx5_flow_meter_policy_get(struct rte_eth_dev *de=
v,
>                                                               &policy_idx=
);
>  }
>
> -#if defined(HAVE_MLX5_HWS_SUPPORT)
> -/**
> - * Callback to delete MTR policy for HWS.
> - *
> - * @param[in] dev
> - *   Pointer to Ethernet device.
> - * @param[in] policy_id
> - *   Meter policy id.
> - * @param[out] error
> - *   Pointer to the error structure.
> - *
> - * @return
> - *   0 on success, a negative errno value otherwise and rte_errno is set=
.
> - */
> -static int
> -mlx5_flow_meter_policy_hws_delete(struct rte_eth_dev *dev,
> -                         uint32_t policy_id,
> -                         struct rte_mtr_error *error)
> -{
> -       struct mlx5_priv *priv =3D dev->data->dev_private;
> -       struct mlx5_flow_meter_policy *mtr_policy;
> -       uint32_t i, j;
> -       uint32_t nb_flows =3D 0;
> -       int ret;
> -       struct rte_flow_op_attr op_attr =3D { .postpone =3D 1 };
> -       struct rte_flow_op_result result[RTE_COLORS * MLX5_MTR_DOMAIN_MAX=
];
> -
> -       if (!priv->mtr_policy_arr)
> -               return mlx5_flow_meter_policy_delete(dev, policy_id,
> error);
> -       /* Meter policy must exist. */
> -       mtr_policy =3D mlx5_flow_meter_policy_find(dev, policy_id, NULL);
> -       if (!mtr_policy->initialized)
> -               return -rte_mtr_error_set(error, ENOENT,
> -                       RTE_MTR_ERROR_TYPE_METER_POLICY_ID, NULL,
> -                       "Meter policy does not exists.");
> -       /* Check policy is unused. */
> -       if (mtr_policy->ref_cnt)
> -               return -rte_mtr_error_set(error, EBUSY,
> -
>  RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
> -                                         NULL, "Meter policy is in use."=
);
> -       rte_spinlock_lock(&priv->hw_ctrl_lock);
> -       for (i =3D 0; i < MLX5_MTR_DOMAIN_MAX; i++) {
> -               for (j =3D 0; j < RTE_COLORS; j++) {
> -                       if (mtr_policy->hws_flow_rule[i][j]) {
> -                               ret =3D
> rte_flow_async_destroy(dev->data->port_id,
> -                                       CTRL_QUEUE_ID(priv), &op_attr,
> -                                       mtr_policy->hws_flow_rule[i][j],
> -                                       NULL, NULL);
> -                               if (ret < 0)
> -                                       continue;
> -                               nb_flows++;
> -                       }
> -               }
> -       }
> -       ret =3D rte_flow_push(dev->data->port_id, CTRL_QUEUE_ID(priv), NU=
LL);
> -       while (nb_flows && (ret >=3D 0)) {
> -               ret =3D rte_flow_pull(dev->data->port_id,
> -                                       CTRL_QUEUE_ID(priv), result,
> -                                       nb_flows, NULL);
> -               nb_flows -=3D ret;
> -       }
> -       for (i =3D 0; i < MLX5_MTR_DOMAIN_MAX; i++) {
> -               if (mtr_policy->hws_flow_table[i])
> -                       rte_flow_template_table_destroy(dev->data->port_i=
d,
> -                                mtr_policy->hws_flow_table[i], NULL);
> -       }
> -       for (i =3D 0; i < RTE_COLORS; i++) {
> -               if (mtr_policy->hws_act_templ[i])
> -
>  rte_flow_actions_template_destroy(dev->data->port_id,
> -                                mtr_policy->hws_act_templ[i], NULL);
> -       }
> -       if (mtr_policy->hws_item_templ)
> -               rte_flow_pattern_template_destroy(dev->data->port_id,
> -                               mtr_policy->hws_item_templ, NULL);
> -       rte_spinlock_unlock(&priv->hw_ctrl_lock);
> -       memset(mtr_policy, 0, sizeof(struct mlx5_flow_meter_policy));
> -       return 0;
> -}
> -
> -/**
> - * Callback to add MTR policy for HWS.
> - *
> - * @param[in] dev
> - *   Pointer to Ethernet device.
> - * @param[out] policy_id
> - *   Pointer to policy id
> - * @param[in] actions
> - *   Pointer to meter policy action detail.
> - * @param[out] error
> - *   Pointer to the error structure.
> - *
> - * @return
> - *   0 on success, a negative errno value otherwise and rte_errno is set=
.
> - */
> -static int
> -mlx5_flow_meter_policy_hws_add(struct rte_eth_dev *dev,
> -                       uint32_t policy_id,
> -                       struct rte_mtr_meter_policy_params *policy,
> -                       struct rte_mtr_error *error)
> -{
> -       struct mlx5_priv *priv =3D dev->data->dev_private;
> -       struct mlx5_flow_meter_policy *mtr_policy =3D NULL;
> -       const struct rte_flow_action *act;
> -       const struct rte_flow_action_meter *mtr;
> -       struct mlx5_flow_meter_info *fm;
> -       struct mlx5_flow_meter_policy *plc;
> -       uint8_t domain_color =3D MLX5_MTR_ALL_DOMAIN_BIT;
> -       bool is_rss =3D false;
> -       bool is_hierarchy =3D false;
> -       int i, j;
> -       uint32_t nb_colors =3D 0;
> -       uint32_t nb_flows =3D 0;
> -       int color;
> -       int ret;
> -       struct rte_flow_pattern_template_attr pta =3D {0};
> -       struct rte_flow_actions_template_attr ata =3D {0};
> -       struct rte_flow_template_table_attr ta =3D { {0}, 0 };
> -       struct rte_flow_op_attr op_attr =3D { .postpone =3D 1 };
> -       struct rte_flow_op_result result[RTE_COLORS * MLX5_MTR_DOMAIN_MAX=
];
> -       const uint32_t color_mask =3D (UINT32_C(1) << MLX5_MTR_COLOR_BITS=
) -
> 1;
> -       int color_reg_c_idx =3D mlx5_flow_get_reg_id(dev, MLX5_MTR_COLOR,
> -                                                  0, NULL);
> -       struct rte_flow_item_tag tag_spec =3D {
> -               .data =3D 0,
> -               .index =3D color_reg_c_idx
> -       };
> -       struct rte_flow_item_tag tag_mask =3D {
> -               .data =3D color_mask,
> -               .index =3D 0xff};
> -       struct rte_flow_item pattern[] =3D {
> -               [0] =3D {
> -                       .type =3D (enum rte_flow_item_type)
> -                               MLX5_RTE_FLOW_ITEM_TYPE_TAG,
> -                       .spec =3D &tag_spec,
> -                       .mask =3D &tag_mask,
> -               },
> -               [1] =3D { .type =3D RTE_FLOW_ITEM_TYPE_END }
> -       };
> -
> -       if (mlx5_hws_active(dev) && !mlx5_hw_ctx_validate(dev, NULL))
> -               return -rte_mtr_error_set(error, EINVAL,
> -                                         RTE_MTR_ERROR_TYPE_UNSPECIFIED,
> NULL,
> -                                         "non-template flow engine was
> not configured");
> -       if (!priv->mtr_policy_arr)
> -               return mlx5_flow_meter_policy_add(dev, policy_id, policy,
> error);
> -       mtr_policy =3D mlx5_flow_meter_policy_find(dev, policy_id, NULL);
> -       if (mtr_policy->initialized)
> -               return -rte_mtr_error_set(error, EEXIST,
> -                       RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
> -                       NULL, "Meter policy already exists.");
> -       if (!policy ||
> -           (!policy->actions[RTE_COLOR_RED] &&
> -           !policy->actions[RTE_COLOR_YELLOW] &&
> -           !policy->actions[RTE_COLOR_GREEN]))
> -               return -rte_mtr_error_set(error, EINVAL,
> -                                         RTE_MTR_ERROR_TYPE_METER_POLICY=
,
> -                                         NULL, "Meter policy actions are
> not valid.");
> -       if (policy->actions[RTE_COLOR_RED] =3D=3D RTE_FLOW_ACTION_TYPE_EN=
D)
> -               mtr_policy->skip_r =3D 1;
> -       if (policy->actions[RTE_COLOR_YELLOW] =3D=3D RTE_FLOW_ACTION_TYPE=
_END)
> -               mtr_policy->skip_y =3D 1;
> -       if (policy->actions[RTE_COLOR_GREEN] =3D=3D RTE_FLOW_ACTION_TYPE_=
END)
> -               mtr_policy->skip_g =3D 1;
> -       if (mtr_policy->skip_r && mtr_policy->skip_y && mtr_policy->skip_=
g)
> -               return -rte_mtr_error_set(error, ENOTSUP,
> -
>  RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
> -                                         NULL, "Meter policy actions are
> empty.");
> -       for (i =3D 0; i < RTE_COLORS; i++) {
> -               act =3D policy->actions[i];
> -               while (act && act->type !=3D RTE_FLOW_ACTION_TYPE_END) {
> -                       switch (act->type) {
> -                       case RTE_FLOW_ACTION_TYPE_PORT_ID:
> -                               /* fall-through. */
> -                       case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
> -                               domain_color &=3D
> ~(MLX5_MTR_DOMAIN_INGRESS_BIT |
> -
>  MLX5_MTR_DOMAIN_EGRESS_BIT);
> -                               break;
> -                       case RTE_FLOW_ACTION_TYPE_RSS:
> -                               is_rss =3D true;
> -                               /* fall-through. */
> -                       case RTE_FLOW_ACTION_TYPE_QUEUE:
> -                               domain_color &=3D
> ~(MLX5_MTR_DOMAIN_EGRESS_BIT |
> -
>  MLX5_MTR_DOMAIN_TRANSFER_BIT);
> -                               break;
> -                       case RTE_FLOW_ACTION_TYPE_METER:
> -                               is_hierarchy =3D true;
> -                               mtr =3D act->conf;
> -                               fm =3D mlx5_flow_meter_find(priv,
> -                                                         mtr->mtr_id,
> NULL);
> -                               if (!fm)
> -                                       return -rte_mtr_error_set(error,
> EINVAL,
> -                                               RTE_MTR_ERROR_TYPE_MTR_ID=
,
> NULL,
> -                                               "Meter not found in meter
> hierarchy.");
> -                               plc =3D mlx5_flow_meter_policy_find(dev,
> -
>  fm->policy_id,
> -                                                                 NULL);
> -                               MLX5_ASSERT(plc);
> -                               domain_color &=3D MLX5_MTR_ALL_DOMAIN_BIT=
 &
> -                                       (plc->ingress <<
> -                                        MLX5_MTR_DOMAIN_INGRESS);
> -                               domain_color &=3D MLX5_MTR_ALL_DOMAIN_BIT=
 &
> -                                       (plc->egress <<
> -                                        MLX5_MTR_DOMAIN_EGRESS);
> -                               domain_color &=3D MLX5_MTR_ALL_DOMAIN_BIT=
 &
> -                                       (plc->transfer <<
> -                                        MLX5_MTR_DOMAIN_TRANSFER);
> -                               break;
> -                       default:
> -                               break;
> -                       }
> -                       act++;
> -               }
> -       }
> -       if (priv->sh->config.dv_esw_en)
> -               domain_color &=3D ~(MLX5_MTR_DOMAIN_EGRESS_BIT |
> -                                 MLX5_MTR_DOMAIN_TRANSFER_BIT);
> -       else
> -               domain_color &=3D ~MLX5_MTR_DOMAIN_TRANSFER_BIT;
> -       if (!domain_color)
> -               return -rte_mtr_error_set(error, ENOTSUP,
> -
>  RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
> -                                         NULL, "Meter policy domains are
> conflicting.");
> -       mtr_policy->is_rss =3D is_rss;
> -       mtr_policy->ingress =3D !!(domain_color &
> MLX5_MTR_DOMAIN_INGRESS_BIT);
> -       pta.ingress =3D mtr_policy->ingress;
> -       mtr_policy->egress =3D !!(domain_color & MLX5_MTR_DOMAIN_EGRESS_B=
IT);
> -       pta.egress =3D mtr_policy->egress;
> -       mtr_policy->transfer =3D !!(domain_color &
> MLX5_MTR_DOMAIN_TRANSFER_BIT);
> -       pta.transfer =3D mtr_policy->transfer;
> -       mtr_policy->group =3D MLX5_FLOW_TABLE_HWS_POLICY - policy_id;
> -       mtr_policy->is_hierarchy =3D is_hierarchy;
> -       mtr_policy->initialized =3D 1;
> -       rte_spinlock_lock(&priv->hw_ctrl_lock);
> -       mtr_policy->hws_item_templ =3D
> -               rte_flow_pattern_template_create(dev->data->port_id,
> -                                                &pta, pattern, NULL);
> -       if (!mtr_policy->hws_item_templ)
> -               goto policy_add_err;
> -       for (i =3D 0; i < RTE_COLORS; i++) {
> -               if (mtr_policy->skip_g && i =3D=3D RTE_COLOR_GREEN)
> -                       continue;
> -               if (mtr_policy->skip_y && i =3D=3D RTE_COLOR_YELLOW)
> -                       continue;
> -               if (mtr_policy->skip_r && i =3D=3D RTE_COLOR_RED)
> -                       continue;
> -               mtr_policy->hws_act_templ[nb_colors] =3D
> -
>  rte_flow_actions_template_create(dev->data->port_id,
> -                                               &ata, policy->actions[i],
> -                                               policy->actions[i], NULL)=
;
> -               if (!mtr_policy->hws_act_templ[nb_colors])
> -                       goto policy_add_err;
> -               nb_colors++;
> -       }
> -       for (i =3D 0; i < MLX5_MTR_DOMAIN_MAX; i++) {
> -               memset(&ta, 0, sizeof(ta));
> -               ta.nb_flows =3D RTE_COLORS;
> -               ta.flow_attr.group =3D mtr_policy->group;
> -               if (i =3D=3D MLX5_MTR_DOMAIN_INGRESS) {
> -                       if (!mtr_policy->ingress)
> -                               continue;
> -                       ta.flow_attr.ingress =3D 1;
> -               } else if (i =3D=3D MLX5_MTR_DOMAIN_EGRESS) {
> -                       if (!mtr_policy->egress)
> -                               continue;
> -                       ta.flow_attr.egress =3D 1;
> -               } else if (i =3D=3D MLX5_MTR_DOMAIN_TRANSFER) {
> -                       if (!mtr_policy->transfer)
> -                               continue;
> -                       ta.flow_attr.transfer =3D 1;
> -               }
> -               mtr_policy->hws_flow_table[i] =3D
> -                       rte_flow_template_table_create(dev->data->port_id=
,
> -                                       &ta, &mtr_policy->hws_item_templ,
> 1,
> -                                       mtr_policy->hws_act_templ,
> nb_colors,
> -                                       NULL);
> -               if (!mtr_policy->hws_flow_table[i])
> -                       goto policy_add_err;
> -               nb_colors =3D 0;
> -               for (j =3D 0; j < RTE_COLORS; j++) {
> -                       if (mtr_policy->skip_g && j =3D=3D RTE_COLOR_GREE=
N)
> -                               continue;
> -                       if (mtr_policy->skip_y && j =3D=3D RTE_COLOR_YELL=
OW)
> -                               continue;
> -                       if (mtr_policy->skip_r && j =3D=3D RTE_COLOR_RED)
> -                               continue;
> -                       color =3D rte_col_2_mlx5_col((enum rte_color)j);
> -                       tag_spec.data =3D color;
> -                       mtr_policy->hws_flow_rule[i][j] =3D
> -                               rte_flow_async_create(dev->data->port_id,
> -                                       CTRL_QUEUE_ID(priv), &op_attr,
> -                                       mtr_policy->hws_flow_table[i],
> -                                       pattern, 0, policy->actions[j],
> -                                       nb_colors, NULL, NULL);
> -                       if (!mtr_policy->hws_flow_rule[i][j])
> -                               goto policy_add_err;
> -                       nb_colors++;
> -                       nb_flows++;
> -               }
> -               ret =3D rte_flow_push(dev->data->port_id,
> -                                   CTRL_QUEUE_ID(priv), NULL);
> -               if (ret < 0)
> -                       goto policy_add_err;
> -               while (nb_flows) {
> -                       ret =3D rte_flow_pull(dev->data->port_id,
> -                                           CTRL_QUEUE_ID(priv), result,
> -                                           nb_flows, NULL);
> -                       if (ret < 0)
> -                               goto policy_add_err;
> -                       for (j =3D 0; j < ret; j++) {
> -                               if (result[j].status =3D=3D RTE_FLOW_OP_E=
RROR)
> -                                       goto policy_add_err;
> -                       }
> -                       nb_flows -=3D ret;
> -               }
> -       }
> -       rte_spinlock_unlock(&priv->hw_ctrl_lock);
> -       return 0;
> -policy_add_err:
> -       rte_spinlock_unlock(&priv->hw_ctrl_lock);
> -       ret =3D mlx5_flow_meter_policy_hws_delete(dev, policy_id, error);
> -       memset(mtr_policy, 0, sizeof(struct mlx5_flow_meter_policy));
> -       if (ret)
> -               return ret;
> -       return -rte_mtr_error_set(error, ENOTSUP,
> -                                 RTE_MTR_ERROR_TYPE_UNSPECIFIED,
> -                                 NULL, "Failed to create meter policy.")=
;
> -}
> -#endif
>  /**
>   * Check meter validation.
>   *
> @@ -2239,105 +1868,6 @@ mlx5_flow_meter_create(struct rte_eth_dev *dev,
> uint32_t meter_id,
>                 NULL, "Failed to create devx meter.");
>  }
>
> -#if defined(HAVE_MLX5_HWS_SUPPORT)
> -/**
> - * Create meter rules.
> - *
> - * @param[in] dev
> - *   Pointer to Ethernet device.
> - * @param[in] meter_id
> - *   Meter id.
> - * @param[in] params
> - *   Pointer to rte meter parameters.
> - * @param[in] shared
> - *   Meter shared with other flow or not.
> - * @param[out] error
> - *   Pointer to rte meter error structure.
> - *
> - * @return
> - *   0 on success, a negative errno value otherwise and rte_errno is set=
.
> - */
> -static int
> -mlx5_flow_meter_hws_create(struct rte_eth_dev *dev, uint32_t meter_id,
> -                      struct rte_mtr_params *params, int shared,
> -                      struct rte_mtr_error *error)
> -{
> -       struct mlx5_priv *priv =3D dev->data->dev_private;
> -       struct mlx5_flow_meter_profile *profile;
> -       struct mlx5_flow_meter_info *fm;
> -       struct mlx5_flow_meter_policy *policy =3D NULL;
> -       struct mlx5_aso_mtr *aso_mtr;
> -       struct mlx5_hw_q_job *job;
> -       int ret;
> -
> -       if (mlx5_hws_active(dev) && !mlx5_hw_ctx_validate(dev, NULL))
> -               return -rte_mtr_error_set(error, EINVAL,
> -                                         RTE_MTR_ERROR_TYPE_UNSPECIFIED,
> NULL,
> -                                         "non-template flow engine was
> not configured");
> -       if (!priv->mtr_profile_arr ||
> -           !priv->mtr_policy_arr ||
> -           !priv->mtr_bulk.aso)
> -               return -rte_mtr_error_set(error, ENOTSUP,
> -                       RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
> -                       "Meter bulk array is not allocated.");
> -       /* Meter profile must exist. */
> -       profile =3D mlx5_flow_meter_profile_find(priv,
> params->meter_profile_id);
> -       if (!profile->initialized)
> -               return -rte_mtr_error_set(error, ENOENT,
> -                       RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
> -                       NULL, "Meter profile id not valid.");
> -       /* Meter policy must exist. */
> -       policy =3D mlx5_flow_meter_policy_find(dev,
> -                       params->meter_policy_id, NULL);
> -       if (!policy->initialized)
> -               return -rte_mtr_error_set(error, ENOENT,
> -                       RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
> -                       NULL, "Meter policy id not valid.");
> -       /* Meter ID must be valid. */
> -       if (meter_id >=3D priv->mtr_config.nb_meters)
> -               return -rte_mtr_error_set(error, EINVAL,
> -                       RTE_MTR_ERROR_TYPE_MTR_ID,
> -                       NULL, "Meter id not valid.");
> -       /* Find ASO object. */
> -       aso_mtr =3D mlx5_aso_meter_by_idx(priv, meter_id);
> -       fm =3D &aso_mtr->fm;
> -       if (fm->initialized)
> -               return -rte_mtr_error_set(error, ENOENT,
> -                                         RTE_MTR_ERROR_TYPE_MTR_ID,
> -                                         NULL, "Meter object already
> exists.");
> -       /* Fill the flow meter parameters. */
> -       fm->meter_id =3D meter_id;
> -       fm->policy_id =3D params->meter_policy_id;
> -       fm->profile =3D profile;
> -       fm->meter_offset =3D meter_id;
> -       fm->group =3D policy->group;
> -       /* Add to the flow meter list. */
> -       fm->active_state =3D 1; /* Config meter starts as active. */
> -       fm->is_enable =3D params->meter_enable;
> -       fm->shared =3D !!shared;
> -       fm->initialized =3D 1;
> -       /* Update ASO flow meter by wqe. */
> -       job =3D mlx5_flow_action_job_init(priv, MLX5_HW_INV_QUEUE, NULL,
> NULL,
> -                                       NULL, MLX5_HW_Q_JOB_TYPE_CREATE,
> NULL);
> -       if (!job)
> -               return -rte_mtr_error_set(error, ENOMEM,
> -                                         RTE_MTR_ERROR_TYPE_MTR_ID,
> -                                         NULL, "No job context.");
> -       ret =3D mlx5_aso_meter_update_by_wqe(priv, MLX5_HW_INV_QUEUE,
> aso_mtr,
> -                                          &priv->mtr_bulk, job, true);
> -       if (ret) {
> -               flow_hw_job_put(priv, job, CTRL_QUEUE_ID(priv));
> -               return -rte_mtr_error_set(error, ENOTSUP,
> -                                         RTE_MTR_ERROR_TYPE_UNSPECIFIED,
> -                                         NULL, "Failed to create devx
> meter.");
> -       }
> -       fm->active_state =3D params->meter_enable;
> -       rte_atomic_fetch_add_explicit(&fm->profile->ref_cnt, 1,
> rte_memory_order_relaxed);
> -       rte_atomic_fetch_add_explicit(&policy->ref_cnt, 1,
> rte_memory_order_relaxed);
> -       return 0;
> -}
> -#endif
> -
>  static int
>  mlx5_flow_meter_params_flush(struct rte_eth_dev *dev,
>                         struct mlx5_flow_meter_info *fm,
> @@ -2444,58 +1974,6 @@ mlx5_flow_meter_destroy(struct rte_eth_dev *dev,
> uint32_t meter_id,
>         return 0;
>  }
>
> -/**
> - * Destroy meter rules.
> - *
> - * @param[in] dev
> - *   Pointer to Ethernet device.
> - * @param[in] meter_id
> - *   Meter id.
> - * @param[out] error
> - *   Pointer to rte meter error structure.
> - *
> - * @return
> - *   0 on success, a negative errno value otherwise and rte_errno is set=
.
> - */
> -static int
> -mlx5_flow_meter_hws_destroy(struct rte_eth_dev *dev, uint32_t meter_id,
> -                       struct rte_mtr_error *error)
> -{
> -       struct mlx5_priv *priv =3D dev->data->dev_private;
> -       struct mlx5_aso_mtr *aso_mtr;
> -       struct mlx5_flow_meter_info *fm;
> -       struct mlx5_flow_meter_policy *policy;
> -
> -       if (!priv->mtr_profile_arr ||
> -           !priv->mtr_policy_arr ||
> -           !priv->mtr_bulk.aso)
> -               return -rte_mtr_error_set(error, ENOTSUP,
> -                       RTE_MTR_ERROR_TYPE_METER_POLICY, NULL,
> -                       "Meter bulk array is not allocated.");
> -       /* Find ASO object. */
> -       aso_mtr =3D mlx5_aso_meter_by_idx(priv, meter_id);
> -       fm =3D &aso_mtr->fm;
> -       if (!fm->initialized)
> -               return -rte_mtr_error_set(error, ENOENT,
> -                                         RTE_MTR_ERROR_TYPE_MTR_ID,
> -                                         NULL, "Meter object id not
> valid.");
> -       /* Meter object must not have any owner. */
> -       if (fm->ref_cnt > 0)
> -               return -rte_mtr_error_set(error, EBUSY,
> -                                         RTE_MTR_ERROR_TYPE_UNSPECIFIED,
> -                                         NULL, "Meter object is being
> used.");
> -       /* Destroy the meter profile. */
> -       rte_atomic_fetch_sub_explicit(&fm->profile->ref_cnt,
> -                                               1,
> rte_memory_order_relaxed);
> -       /* Destroy the meter policy. */
> -       policy =3D mlx5_flow_meter_policy_find(dev,
> -                       fm->policy_id, NULL);
> -       rte_atomic_fetch_sub_explicit(&policy->ref_cnt,
> -                                               1,
> rte_memory_order_relaxed);
> -       memset(fm, 0, sizeof(struct mlx5_flow_meter_info));
> -       return 0;
> -}
> -
>  /**
>   * Modify meter state.
>   *
> @@ -2835,14 +2313,6 @@ static const struct rte_mtr_ops
> mlx5_flow_mtr_hws_ops =3D {
>         .meter_profile_add =3D mlx5_flow_meter_profile_hws_add,
>         .meter_profile_delete =3D mlx5_flow_meter_profile_hws_delete,
>         .meter_profile_get =3D mlx5_flow_meter_profile_get,
> -       .meter_policy_validate =3D mlx5_flow_meter_policy_hws_validate,
> -       .meter_policy_add =3D mlx5_flow_meter_policy_hws_add,
> -       .meter_policy_delete =3D mlx5_flow_meter_policy_hws_delete,
> -       .meter_policy_get =3D mlx5_flow_meter_policy_get,
> -       .create =3D mlx5_flow_meter_hws_create,
> -       .destroy =3D mlx5_flow_meter_hws_destroy,
> -       .meter_enable =3D mlx5_flow_meter_enable,
> -       .meter_disable =3D mlx5_flow_meter_disable,
>         .meter_profile_update =3D mlx5_flow_meter_profile_update,
>         .meter_dscp_table_update =3D NULL,
>         .stats_update =3D NULL,
> @@ -3286,14 +2756,6 @@ mlx5_flow_meter_flush(struct rte_eth_dev *dev,
> struct rte_mtr_error *error)
>                                 NULL, "MTR object meter profile invalid."=
);
>                 }
>         }
> -       if (priv->mtr_bulk.aso) {
> -               for (i =3D 0; i < priv->mtr_config.nb_meters; i++) {
> -                       aso_mtr =3D mlx5_aso_meter_by_idx(priv, i);
> -                       fm =3D &aso_mtr->fm;
> -                       if (fm->initialized)
> -                               mlx5_flow_meter_hws_destroy(dev, i, error=
);
> -               }
> -       }
>         if (priv->policy_idx_tbl) {
>                 MLX5_L3T_FOREACH(priv->policy_idx_tbl, i, entry) {
>                         policy_idx =3D *(uint32_t *)entry;
> @@ -3319,20 +2781,6 @@ mlx5_flow_meter_flush(struct rte_eth_dev *dev,
> struct rte_mtr_error *error)
>                 mlx5_l3t_destroy(priv->policy_idx_tbl);
>                 priv->policy_idx_tbl =3D NULL;
>         }
> -#if defined(HAVE_MLX5_HWS_SUPPORT)
> -       if (priv->mtr_policy_arr) {
> -               struct mlx5_flow_meter_policy *policy;
> -
> -               for (i =3D 0; i < priv->mtr_config.nb_meter_policies; i++=
) {
> -                       policy =3D mlx5_flow_meter_policy_find(dev, i,
> -                                                            &policy_idx)=
;
> -                       if (policy->initialized) {
> -                               mlx5_flow_meter_policy_hws_delete(dev, i,
> -                                                                 error);
> -                       }
> -               }
> -       }
> -#endif
>         if (priv->mtr_profile_tbl) {
>                 MLX5_L3T_FOREACH(priv->mtr_profile_tbl, i, entry) {
>                         fmp =3D entry;
> --
> 2.48.1
>
>

--00000000000013f26a063455fd3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+UGxlYXNlIGRpc3JlZ2FyZCB0aGUgQ29tbXVuaXR5IExhYiBEVFMgZmFp
bHVyZSBqdXN0wqByZXBvcnRlZCBvbiB0aGlzIHBhdGNoc2VyaWVzLiBJIG5lZWQgdG8gcmVjb25m
aWd1cmUgdGhlIHRlc3RiZWQgYW5kIHJlcnVuIHRoZSB0ZXN0LjwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNz
PSJnbWFpbF9hdHRyIj5PbiBTdW4sIE1heSA0LCAyMDI1IGF0IDE6MjTigK9BTSBHcmVnb3J5IEV0
ZWxzb24gJmx0OzxhIGhyZWY9Im1haWx0bzpnZXRlbHNvbkBudmlkaWEuY29tIj5nZXRlbHNvbkBu
dmlkaWEuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHgg
c29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5NRVRFUiBmbG93IGFjdGlv
biBpcyBub3Qgc3VwcG9ydGVkIGluIE1MWDUgSFdTIG1vZGUuPGJyPg0KQXBwbGljYXRpb24gbXVz
dCB1c2UgTUVURVJfTUFSSyBmbG93IGFjdGlvbi48YnI+DQo8YnI+DQpUaGUgcGF0Y2ggcmVtb3Zl
cyBNRVRFUiBhY3Rpb24gZnJvbSBIV1MgY29kZS48YnI+DQo8YnI+DQpGaXhlczogNDhmYmIwZTkz
ZDA2ICgmcXVvdDtuZXQvbWx4NTogc3VwcG9ydCBmbG93IG1ldGVyIG1hcmsgaW5kaXJlY3QgYWN0
aW9uIHdpdGggSFdTJnF1b3Q7KTxicj4NClNpZ25lZC1vZmYtYnk6IEdyZWdvcnkgRXRlbHNvbiAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmdldGVsc29uQG52aWRpYS5jb20iIHRhcmdldD0iX2JsYW5rIj5n
ZXRlbHNvbkBudmlkaWEuY29tPC9hPiZndDs8YnI+DQpBY2tlZC1ieTogRGFyaXVzeiBTb3Nub3dz
a2kgJmx0OzxhIGhyZWY9Im1haWx0bzpkc29zbm93c2tpQG52aWRpYS5jb20iIHRhcmdldD0iX2Js
YW5rIj5kc29zbm93c2tpQG52aWRpYS5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCsKgZHJpdmVy
cy9uZXQvbWx4NS9tbHg1X2Zsb3dfaHcuY8KgIMKgIHzCoCA4NSAtLS0tLTxicj4NCsKgZHJpdmVy
cy9uZXQvbWx4NS9tbHg1X2Zsb3dfbWV0ZXIuYyB8IDU1MiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj4NCsKgMiBmaWxlcyBjaGFuZ2VkLCA2MzcgZGVsZXRpb25zKC0pPGJyPg0KPGJy
Pg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L21seDUvbWx4NV9mbG93X2h3LmMgYi9kcml2ZXJz
L25ldC9tbHg1L21seDVfZmxvd19ody5jPGJyPg0KaW5kZXggMjBkMzhjZTQxNC4uMWYxOTJjMTkz
NyAxMDA2NDQ8YnI+DQotLS0gYS9kcml2ZXJzL25ldC9tbHg1L21seDVfZmxvd19ody5jPGJyPg0K
KysrIGIvZHJpdmVycy9uZXQvbWx4NS9tbHg1X2Zsb3dfaHcuYzxicj4NCkBAIC0xNzg0LDM1ICsx
Nzg0LDYgQEAgZmxvd19od19yZXByZXNlbnRlZF9wb3J0X2NvbXBpbGUoc3RydWN0IHJ0ZV9ldGhf
ZGV2ICpkZXYsPGJyPg0KwqAgwqAgwqAgwqAgcmV0dXJuIDA7PGJyPg0KwqB9PGJyPg0KPGJyPg0K
LXN0YXRpYyBfX3J0ZV9hbHdheXNfaW5saW5lIGludDxicj4NCi1mbG93X2h3X21ldGVyX2NvbXBp
bGUoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY29uc3Qgc3RydWN0IG1seDVfZmxvd190ZW1wbGF0ZV90YWJsZV9jZmcgKmNmZyw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50MTZfdCBhc29fbXRyX3Bv
cyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50MTZfdCBqdW1wX3Bv
cyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgcnRl
X2Zsb3dfYWN0aW9uICphY3Rpb24sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3RydWN0IG1seDVfaHdfYWN0aW9ucyAqYWN0cyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfZXJyb3IgKmVycm9yKTxicj4NCi17PGJyPg0K
LcKgIMKgIMKgIMKgc3RydWN0IG1seDVfcHJpdiAqcHJpdiA9IGRldi0mZ3Q7ZGF0YS0mZ3Q7ZGV2
X3ByaXZhdGU7PGJyPg0KLcKgIMKgIMKgIMKgc3RydWN0IG1seDVfYXNvX210ciAqYXNvX210cjs8
YnI+DQotwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX21ldGVyICptZXRl
ciA9IGFjdGlvbi0mZ3Q7Y29uZjs8YnI+DQotwqAgwqAgwqAgwqB1aW50MzJfdCBncm91cCA9IGNm
Zy0mZ3Q7YXR0ci5mbG93X2F0dHIuZ3JvdXA7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoGFzb19t
dHIgPSBtbHg1X2Fzb19tZXRlcl9ieV9pZHgocHJpdiwgbWV0ZXItJmd0O210cl9pZCk7PGJyPg0K
LcKgIMKgIMKgIMKgYWN0cy0mZ3Q7cnVsZV9hY3RzW2Fzb19tdHJfcG9zXS5hY3Rpb24gPSBwcml2
LSZndDttdHJfYnVsay5hY3Rpb247PGJyPg0KLcKgIMKgIMKgIMKgYWN0cy0mZ3Q7cnVsZV9hY3Rz
W2Fzb19tdHJfcG9zXS5hc29fbWV0ZXIub2Zmc2V0ID0gYXNvX210ci0mZ3Q7b2Zmc2V0Ozxicj4N
Ci3CoCDCoCDCoCDCoGFjdHMtJmd0O2p1bXAgPSBmbG93X2h3X2p1bXBfYWN0aW9uX3JlZ2lzdGVy
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKGRldiwgY2ZnLCBhc29fbXRyLSZndDtmbS5n
cm91cCwgZXJyb3IpOzxicj4NCi3CoCDCoCDCoCDCoGlmICghYWN0cy0mZ3Q7anVtcCk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVOT01FTTs8YnI+DQotwqAgwqAgwqAgwqBh
Y3RzLSZndDtydWxlX2FjdHNbanVtcF9wb3NdLmFjdGlvbiA9ICghIWdyb3VwKSA/PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYWN0cy0m
Z3Q7anVtcC0mZ3Q7aHdzX2FjdGlvbiA6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYWN0cy0mZ3Q7anVtcC0mZ3Q7cm9vdF9hY3Rpb247
PGJyPg0KLcKgIMKgIMKgIMKgaWYgKG1seDVfYXNvX210cl93YWl0KHByaXYsIGFzb19tdHIsIHRy
dWUpKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRU5PTUVNOzxicj4NCi3C
oCDCoCDCoCDCoHJldHVybiAwOzxicj4NCi19PGJyPg0KLTxicj4NCsKgc3RhdGljIF9fcnRlX2Fs
d2F5c19pbmxpbmUgaW50PGJyPg0KwqBmbG93X2h3X2NudF9jb21waWxlKHN0cnVjdCBydGVfZXRo
X2RldiAqZGV2LCB1aW50MzJfdMKgIHN0YXJ0X3Bvcyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzdHJ1Y3QgbWx4NV9od19hY3Rpb25zICphY3RzKTxicj4NCkBAIC0yNTM0
LDcgKzI1MDUsNiBAQCBfX2Zsb3dfaHdfdHJhbnNsYXRlX2FjdGlvbnNfdGVtcGxhdGUoc3RydWN0
IHJ0ZV9ldGhfZGV2ICpkZXYsPGJyPg0KwqAgwqAgwqAgwqAgYm9vbCByZWZvcm1hdF91c2VkID0g
ZmFsc2U7PGJyPg0KwqAgwqAgwqAgwqAgYm9vbCByZWNvbV91c2VkID0gZmFsc2U7PGJyPg0KwqAg
wqAgwqAgwqAgdW5zaWduZWQgaW50IG9mX3ZsYW5fb2Zmc2V0Ozxicj4NCi3CoCDCoCDCoCDCoHVp
bnQxNl90IGp1bXBfcG9zOzxicj4NCsKgIMKgIMKgIMKgIHVpbnQzMl90IGN0X2lkeDs8YnI+DQrC
oCDCoCDCoCDCoCBpbnQgcmV0LCBlcnI7PGJyPg0KwqAgwqAgwqAgwqAgdWludDMyX3QgdGFyZ2V0
X2dycCA9IDA7PGJyPg0KQEAgLTI4MDIsMjcgKzI3NzIsNiBAQCBfX2Zsb3dfaHdfdHJhbnNsYXRl
X2FjdGlvbnNfdGVtcGxhdGUoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXNr
cywgYWN0cywgc3JjX3BvcywgZHJfcG9zLCAmYW1wO3N1Yl9lcnJvcikpPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnI7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9NRVRFUjo8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAqIE1FVEVSIGFjdGlvbiBpcyBjb21waWxlZCB0byAyIERSIGFjdGlv
bnMgLSBBU09fTUVURVIgYW5kIEZULjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAqIENhbGN1bGF0ZWQgRFIgb2Zmc2V0IGlzIHN0b3JlZCBvbmx5IGZvciBBU09fTUVU
RVIgYW5kIEZUPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogaXMg
YXNzdW1lZCB0byBiZSB0aGUgbmV4dCBhY3Rpb24uPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICovPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKganVtcF9wb3MgPSBkcl9wb3MgKyAxOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIChhY3Rpb25zLSZndDtjb25mICZhbXA7JmFtcDsgbWFza3MtJmd0O2NvbmYg
JmFtcDsmYW1wOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCgoY29uc3Qgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9tZXRlciAqKTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtYXNrcy0mZ3Q7Y29uZiktJmd0O210cl9p
ZCkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGVyciA9IGZsb3dfaHdfbWV0ZXJfY29tcGlsZShkZXYsIGNmZyw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBkcl9wb3MsIGp1bXBfcG9zLCBhY3Rpb25zLCBhY3RzLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7c3ViX2Vycm9yKTs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZXJyKTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGdvdG8gZXJyOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oH0gZWxzZSBpZiAoX19mbG93X2h3X2FjdF9kYXRhX2dlbmVyYWxfYXBwZW5kKHByaXYsIGFjdHMs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFjdGlv
bnMtJmd0O3R5cGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHNyY19wb3MsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGRyX3BvcykpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZ290byBlcnI7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYnJlYWs7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2FzZSBSVEVfRkxP
V19BQ1RJT05fVFlQRV9BR0U6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmV0ID0gZmxvd19od190cmFuc2xhdGVfZ3JvdXAoZGV2LCBjZmcsIGF0dHItJmd0O2dyb3Vw
LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7dGFyZ2V0X2dycCwgJmFtcDtzdWJfZXJyb3IpOzxi
cj4NCkBAIC0zNTEwLDcgKzM0NTksNiBAQCBmbG93X2h3X2FjdGlvbnNfY29uc3RydWN0KHN0cnVj
dCBydGVfZXRoX2RldiAqZGV2LDxicj4NCsKgIMKgIMKgIMKgIGNvbnN0IHN0cnVjdCBydGVfZmxv
d19hY3Rpb25faXB2Nl9leHRfcHVzaCAqaXB2Nl9wdXNoOzxicj4NCsKgIMKgIMKgIMKgIGNvbnN0
IHN0cnVjdCBydGVfZmxvd19pdGVtICplbmNfaXRlbSA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAg
Y29uc3Qgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9ldGhkZXYgKnBvcnRfYWN0aW9uID0gTlVMTDs8
YnI+DQotwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX21ldGVyICptZXRl
ciA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAgY29uc3Qgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9h
Z2UgKmFnZSA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAgY29uc3Qgc3RydWN0IHJ0ZV9mbG93X2Fj
dGlvbl9uYXQ2NCAqbmF0NjRfYyA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IHJ0ZV9m
bG93X2F0dHIgYXR0ciA9IHs8YnI+DQpAQCAtMzY4MywyOCArMzYzMSw2IEBAIGZsb3dfaHdfYWN0
aW9uc19jb25zdHJ1Y3Qoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcnVsZV9hY3RzICsgYWN0X2RhdGEtJmd0O2FjdGlvbl9kc3QsPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgYWN0X2RhdGEtJmd0OzxhIGhyZWY9Imh0dHA6Ly9zaGFyZWRfbWV0ZXIuaWQiIHJlbD0ibm9y
ZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnNoYXJlZF9tZXRlci5pZDwvYT4pOzxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfTUVURVI6PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWV0ZXIgPSBhY3Rpb24tJmd0O2NvbmY7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbXRyX2lkID0gbWV0ZXItJmd0O210
cl9pZDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhc29fbXRyID0g
bWx4NV9hc29fbWV0ZXJfYnlfaWR4KHByaXYsIG10cl9pZCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcnVsZV9hY3RzW2FjdF9kYXRhLSZndDthY3Rpb25fZHN0XS5h
Y3Rpb24gPTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHByaXYtJmd0O210cl9idWxrLmFjdGlvbjs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBydWxlX2FjdHNbYWN0X2RhdGEtJmd0O2FjdGlvbl9kc3RdLmFzb19tZXRl
ci5vZmZzZXQgPTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFz
b19tdHItJmd0O29mZnNldDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBqdW1wID0gZmxvd19od19qdW1wX2FjdGlvbl9yZWdpc3Rlcjxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChkZXYsICZhbXA7dGFibGUtJmd0O2Nm
ZywgYXNvX210ci0mZ3Q7Zm0uZ3JvdXAsIE5VTEwpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmICghanVtcCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVycm9yOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoE1MWDVfQVNTRVJUPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKCFydWxlX2FjdHNbYWN0X2RhdGEtJmd0O2FjdGlv
bl9kc3QgKyAxXS5hY3Rpb24pOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJ1bGVfYWN0c1thY3RfZGF0YS0mZ3Q7YWN0aW9uX2RzdCArIDFdLmFjdGlvbiA9PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKCEhYXR0ci5ncm91cCkgPyBqdW1wLSZndDtod3NfYWN0aW9uIDo8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAganVtcC0mZ3Q7cm9vdF9hY3Rpb247PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmxvdy0mZ3Q7anVtcCA9IGp1bXA7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmxvdy0mZ3Q7ZmxhZ3MgfD0gTUxYNV9GTE9X
X0hXX0ZMT1dfRkxBR19GQVRFX0pVTVA7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKG1seDVfYXNvX210cl93YWl0KHByaXYsIGFzb19tdHIsIHRydWUpKTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJy
b3I7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9BR0U6PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXV4ID0gbWx4NV9mbG93X2h3
X2F1eChkZXYtJmd0O2RhdGEtJmd0O3BvcnRfaWQsIGZsb3cpOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFnZSA9IGFjdGlvbi0mZ3Q7Y29uZjs8YnI+DQpAQCAtNzMz
NCwxMCArNzI2MCw2IEBAIG1seDVfZmxvd19od19hY3Rpb25zX3ZhbGlkYXRlKHN0cnVjdCBydGVf
ZXRoX2RldiAqZGV2LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhY3Rpb25fZmxhZ3MgfD0g
TUxYNV9GTE9XX0FDVElPTl9JUFY2X1JPVVRJTkdfUkVNT1ZFOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfTUVURVI6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLyogVE9ETzogVmFsaWRhdGlvbiBsb2dpYyAqLzxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFjdGlvbl9mbGFncyB8PSBNTFg1X0ZMT1df
QUNUSU9OX01FVEVSOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJy
ZWFrOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZ
UEVfTUVURVJfTUFSSzo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXQgPSBmbG93X2h3X3ZhbGlkYXRlX2FjdGlvbl9tZXRlcl9tYXJrKGRldiwgYWN0aW9uLCBmYWxz
ZSwgZXJyb3IpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChy
ZXQgJmx0OyAwKTxicj4NCkBAIC03NjY1LDEzICs3NTg3LDYgQEAgZmxvd19od19wYXJzZV9mbG93
X2FjdGlvbnNfdG9fZHJfYWN0aW9ucyhzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiw8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhY3Rpb25fdHlwZXNb
bWhkcl9vZmZdID0gdHlwZTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9NRVRFUjo8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhdC0mZ3Q7ZHJfb2ZmW2ld
ID0gY3Vycl9vZmY7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYWN0
aW9uX3R5cGVzW2N1cnJfb2ZmKytdID0gTUxYNURSX0FDVElPTl9UWVBfQVNPX01FVEVSOzxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChjdXJyX29mZiAmZ3Q7PSBN
TFg1X0hXX01BWF9BQ1RTKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdvdG8gZXJyX2FjdGlvbnNfbnVtOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGFjdGlvbl90eXBlc1tjdXJyX29mZisrXSA9IE1MWDVEUl9BQ1RJ
T05fVFlQX1RCTDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVh
azs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBF
X09GX1BVU0hfVkxBTjo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0
eXBlID0gbWx4NV9od19kcl9hY3Rpb25fdHlwZXNbYXQtJmd0O2FjdGlvbnNbaV0udHlwZV07PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXQtJmd0O2RyX29mZltpXSA9
IGN1cnJfb2ZmOzxicj4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9tbHg1L21seDVfZmxvd19t
ZXRlci5jIGIvZHJpdmVycy9uZXQvbWx4NS9tbHg1X2Zsb3dfbWV0ZXIuYzxicj4NCmluZGV4IGRh
YjNjNGJmNzcuLmNkNmE4MDQ1OTMgMTAwNjQ0PGJyPg0KLS0tIGEvZHJpdmVycy9uZXQvbWx4NS9t
bHg1X2Zsb3dfbWV0ZXIuYzxicj4NCisrKyBiL2RyaXZlcnMvbmV0L21seDUvbWx4NV9mbG93X21l
dGVyLmM8YnI+DQpAQCAtMTE2Niw0OSArMTE2Niw2IEBAIG1seDVfZmxvd19tZXRlcl9wb2xpY3lf
dmFsaWRhdGUoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsPGJyPg0KwqAgwqAgwqAgwqAgcmV0dXJu
IDA7PGJyPg0KwqB9PGJyPg0KPGJyPg0KLSNpZiBkZWZpbmVkKEhBVkVfTUxYNV9IV1NfU1VQUE9S
VCk8YnI+DQotLyoqPGJyPg0KLSAqIENhbGxiYWNrIHRvIGNoZWNrIE1UUiBwb2xpY3kgYWN0aW9u
IHZhbGlkYXRlIGZvciBIV1M8YnI+DQotICo8YnI+DQotICogQHBhcmFtW2luXSBkZXY8YnI+DQot
ICrCoCDCoFBvaW50ZXIgdG8gRXRoZXJuZXQgZGV2aWNlLjxicj4NCi0gKiBAcGFyYW1baW5dIGFj
dGlvbnM8YnI+DQotICrCoCDCoFBvaW50ZXIgdG8gbWV0ZXIgcG9saWN5IGFjdGlvbiBkZXRhaWwu
PGJyPg0KLSAqIEBwYXJhbVtvdXRdIGVycm9yPGJyPg0KLSAqwqAgwqBQb2ludGVyIHRvIHRoZSBl
cnJvciBzdHJ1Y3R1cmUuPGJyPg0KLSAqPGJyPg0KLSAqIEByZXR1cm48YnI+DQotICrCoCDCoDAg
b24gc3VjY2VzcywgYSBuZWdhdGl2ZSBlcnJubyB2YWx1ZSBvdGhlcndpc2UgYW5kIHJ0ZV9lcnJu
byBpcyBzZXQuPGJyPg0KLSAqLzxicj4NCi1zdGF0aWMgaW50PGJyPg0KLW1seDVfZmxvd19tZXRl
cl9wb2xpY3lfaHdzX3ZhbGlkYXRlKHN0cnVjdCBydGVfZXRoX2RldiAqZGV2LDxicj4NCi3CoCDC
oCDCoCDCoHN0cnVjdCBydGVfbXRyX21ldGVyX3BvbGljeV9wYXJhbXMgKnBvbGljeSw8YnI+DQot
wqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX210cl9lcnJvciAqZXJyb3IpPGJyPg0KLXs8YnI+DQotwqAg
wqAgwqAgwqBzdHJ1Y3QgbWx4NV9wcml2ICpwcml2ID0gZGV2LSZndDtkYXRhLSZndDtkZXZfcHJp
dmF0ZTs8YnI+DQotwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uc190ZW1w
bGF0ZV9hdHRyIGF0dHIgPSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLnRyYW5zZmVy
ID0gcHJpdi0mZ3Q7c2gtJmd0O2NvbmZpZy5kdl9lc3dfZW4gPyAxIDogMCB9Ozxicj4NCi3CoCDC
oCDCoCDCoGludCByZXQ7PGJyPg0KLcKgIMKgIMKgIMKgaW50IGk7PGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoGlmIChtbHg1X2h3c19hY3RpdmUoZGV2KSAmYW1wOyZhbXA7ICFtbHg1X2h3X2N0eF92
YWxpZGF0ZShkZXYsIE5VTEwpKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAt
cnRlX210cl9lcnJvcl9zZXQoZXJyb3IsIEVJTlZBTCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBSVEVfTVRSX0VSUk9S
X1RZUEVfVU5TUEVDSUZJRUQsIE5VTEwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7bm9uLXRlbXBsYXRlIGZs
b3cgZW5naW5lIHdhcyBub3QgY29uZmlndXJlZCZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgaWYg
KCFwcml2LSZndDttdHJfZW4gfHwgIXByaXYtJmd0O3NoLSZndDttZXRlcl9hc29fZW4pPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1ydGVfbXRyX2Vycm9yX3NldChlcnJvciwg
RU5PVFNVUCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBSVEVfTVRSX0VSUk9SX1RZUEVfTUVURVJfUE9MSUNZLDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsICZxdW90O21ldGVyIHBvbGlj
eSB1bnN1cHBvcnRlZC4mcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0
OyBSVEVfQ09MT1JTOyBpKyspIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBt
bHg1X2Zsb3dfYWN0aW9uc192YWxpZGF0ZShkZXYsICZhbXA7YXR0ciwgcG9saWN5LSZndDthY3Rp
b25zW2ldLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwb2xpY3ktJmd0O2FjdGlvbnNbaV0sIE5VTEwp
Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQpPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQotwqAgwqAgwqAgwqB9PGJy
Pg0KLcKgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KLX08YnI+DQotI2VuZGlmPGJyPg0KLTxicj4N
CsKgc3RhdGljIGludDxicj4NCsKgX19tbHg1X2Zsb3dfbWV0ZXJfcG9saWN5X2RlbGV0ZShzdHJ1
Y3QgcnRlX2V0aF9kZXYgKmRldiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB1aW50MzJfdCBwb2xpY3lfaWQsPGJyPg0KQEAgLTE1NDAsMzM0ICsxNDk3LDYgQEAgbWx4
NV9mbG93X21ldGVyX3BvbGljeV9nZXQoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtwb2xpY3lfaWR4KTs8YnI+DQrC
oH08YnI+DQo8YnI+DQotI2lmIGRlZmluZWQoSEFWRV9NTFg1X0hXU19TVVBQT1JUKTxicj4NCi0v
Kio8YnI+DQotICogQ2FsbGJhY2sgdG8gZGVsZXRlIE1UUiBwb2xpY3kgZm9yIEhXUy48YnI+DQot
ICo8YnI+DQotICogQHBhcmFtW2luXSBkZXY8YnI+DQotICrCoCDCoFBvaW50ZXIgdG8gRXRoZXJu
ZXQgZGV2aWNlLjxicj4NCi0gKiBAcGFyYW1baW5dIHBvbGljeV9pZDxicj4NCi0gKsKgIMKgTWV0
ZXIgcG9saWN5IGlkLjxicj4NCi0gKiBAcGFyYW1bb3V0XSBlcnJvcjxicj4NCi0gKsKgIMKgUG9p
bnRlciB0byB0aGUgZXJyb3Igc3RydWN0dXJlLjxicj4NCi0gKjxicj4NCi0gKiBAcmV0dXJuPGJy
Pg0KLSAqwqAgwqAwIG9uIHN1Y2Nlc3MsIGEgbmVnYXRpdmUgZXJybm8gdmFsdWUgb3RoZXJ3aXNl
IGFuZCBydGVfZXJybm8gaXMgc2V0Ljxicj4NCi0gKi88YnI+DQotc3RhdGljIGludDxicj4NCi1t
bHg1X2Zsb3dfbWV0ZXJfcG9saWN5X2h3c19kZWxldGUoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDMyX3QgcG9s
aWN5X2lkLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVj
dCBydGVfbXRyX2Vycm9yICplcnJvcik8YnI+DQotezxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBt
bHg1X3ByaXYgKnByaXYgPSBkZXYtJmd0O2RhdGEtJmd0O2Rldl9wcml2YXRlOzxicj4NCi3CoCDC
oCDCoCDCoHN0cnVjdCBtbHg1X2Zsb3dfbWV0ZXJfcG9saWN5ICptdHJfcG9saWN5Ozxicj4NCi3C
oCDCoCDCoCDCoHVpbnQzMl90IGksIGo7PGJyPg0KLcKgIMKgIMKgIMKgdWludDMyX3QgbmJfZmxv
d3MgPSAwOzxicj4NCi3CoCDCoCDCoCDCoGludCByZXQ7PGJyPg0KLcKgIMKgIMKgIMKgc3RydWN0
IHJ0ZV9mbG93X29wX2F0dHIgb3BfYXR0ciA9IHsgLnBvc3Rwb25lID0gMSB9Ozxicj4NCi3CoCDC
oCDCoCDCoHN0cnVjdCBydGVfZmxvd19vcF9yZXN1bHQgcmVzdWx0W1JURV9DT0xPUlMgKiBNTFg1
X01UUl9ET01BSU5fTUFYXTs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgaWYgKCFwcml2LSZndDtt
dHJfcG9saWN5X2Fycik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gbWx4NV9m
bG93X21ldGVyX3BvbGljeV9kZWxldGUoZGV2LCBwb2xpY3lfaWQsIGVycm9yKTs8YnI+DQotwqAg
wqAgwqAgwqAvKiBNZXRlciBwb2xpY3kgbXVzdCBleGlzdC4gKi88YnI+DQotwqAgwqAgwqAgwqBt
dHJfcG9saWN5ID0gbWx4NV9mbG93X21ldGVyX3BvbGljeV9maW5kKGRldiwgcG9saWN5X2lkLCBO
VUxMKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAoIW10cl9wb2xpY3ktJmd0O2luaXRpYWxpemVkKTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtcnRlX210cl9lcnJvcl9zZXQoZXJy
b3IsIEVOT0VOVCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBSVEVf
TVRSX0VSUk9SX1RZUEVfTUVURVJfUE9MSUNZX0lELCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O01ldGVyIHBvbGljeSBkb2VzIG5vdCBleGlzdHMu
JnF1b3Q7KTs8YnI+DQotwqAgwqAgwqAgwqAvKiBDaGVjayBwb2xpY3kgaXMgdW51c2VkLiAqLzxi
cj4NCi3CoCDCoCDCoCDCoGlmIChtdHJfcG9saWN5LSZndDtyZWZfY250KTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiAtcnRlX210cl9lcnJvcl9zZXQoZXJyb3IsIEVCVVNZLDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFJURV9NVFJfRVJST1JfVFlQRV9NRVRFUl9QT0xJQ1lfSUQsPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
TlVMTCwgJnF1b3Q7TWV0ZXIgcG9saWN5IGlzIGluIHVzZS4mcXVvdDspOzxicj4NCi3CoCDCoCDC
oCDCoHJ0ZV9zcGlubG9ja19sb2NrKCZhbXA7cHJpdi0mZ3Q7aHdfY3RybF9sb2NrKTs8YnI+DQot
wqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgTUxYNV9NVFJfRE9NQUlOX01BWDsgaSsrKSB7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChqID0gMDsgaiAmbHQ7IFJURV9DT0xP
UlM7IGorKykgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICht
dHJfcG9saWN5LSZndDtod3NfZmxvd19ydWxlW2ldW2pdKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gcnRlX2Zsb3dfYXN5bmNfZGVz
dHJveShkZXYtJmd0O2RhdGEtJmd0O3BvcnRfaWQsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQ1RSTF9RVUVVRV9JRChwcml2
KSwgJmFtcDtvcF9hdHRyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG10cl9wb2xpY3ktJmd0O2h3c19mbG93X3J1bGVbaV1b
al0sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgTlVMTCwgTlVMTCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmJfZmxv
d3MrKzs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQotwqAgwqAgwqAg
wqByZXQgPSBydGVfZmxvd19wdXNoKGRldi0mZ3Q7ZGF0YS0mZ3Q7cG9ydF9pZCwgQ1RSTF9RVUVV
RV9JRChwcml2KSwgTlVMTCk7PGJyPg0KLcKgIMKgIMKgIMKgd2hpbGUgKG5iX2Zsb3dzICZhbXA7
JmFtcDsgKHJldCAmZ3Q7PSAwKSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9
IHJ0ZV9mbG93X3B1bGwoZGV2LSZndDtkYXRhLSZndDtwb3J0X2lkLDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENUUkxfUVVF
VUVfSUQocHJpdiksIHJlc3VsdCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBuYl9mbG93cywgTlVMTCk7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgbmJfZmxvd3MgLT0gcmV0Ozxicj4NCi3CoCDCoCDCoCDCoH08YnI+
DQotwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgTUxYNV9NVFJfRE9NQUlOX01BWDsgaSsr
KSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG10cl9wb2xpY3ktJmd0O2h3c19m
bG93X3RhYmxlW2ldKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0
ZV9mbG93X3RlbXBsYXRlX3RhYmxlX2Rlc3Ryb3koZGV2LSZndDtkYXRhLSZndDtwb3J0X2lkLDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtdHJf
cG9saWN5LSZndDtod3NfZmxvd190YWJsZVtpXSwgTlVMTCk7PGJyPg0KLcKgIMKgIMKgIMKgfTxi
cj4NCi3CoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBSVEVfQ09MT1JTOyBpKyspIHs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobXRyX3BvbGljeS0mZ3Q7aHdzX2FjdF90ZW1w
bFtpXSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfZmxvd19h
Y3Rpb25zX3RlbXBsYXRlX2Rlc3Ryb3koZGV2LSZndDtkYXRhLSZndDtwb3J0X2lkLDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtdHJfcG9saWN5
LSZndDtod3NfYWN0X3RlbXBsW2ldLCBOVUxMKTs8YnI+DQotwqAgwqAgwqAgwqB9PGJyPg0KLcKg
IMKgIMKgIMKgaWYgKG10cl9wb2xpY3ktJmd0O2h3c19pdGVtX3RlbXBsKTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJ0ZV9mbG93X3BhdHRlcm5fdGVtcGxhdGVfZGVzdHJveShkZXYtJmd0
O2RhdGEtJmd0O3BvcnRfaWQsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgbXRyX3BvbGljeS0mZ3Q7aHdzX2l0ZW1fdGVtcGwsIE5VTEwpOzxicj4N
Ci3CoCDCoCDCoCDCoHJ0ZV9zcGlubG9ja191bmxvY2soJmFtcDtwcml2LSZndDtod19jdHJsX2xv
Y2spOzxicj4NCi3CoCDCoCDCoCDCoG1lbXNldChtdHJfcG9saWN5LCAwLCBzaXplb2Yoc3RydWN0
IG1seDVfZmxvd19tZXRlcl9wb2xpY3kpKTs8YnI+DQotwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+
DQotfTxicj4NCi08YnI+DQotLyoqPGJyPg0KLSAqIENhbGxiYWNrIHRvIGFkZCBNVFIgcG9saWN5
IGZvciBIV1MuPGJyPg0KLSAqPGJyPg0KLSAqIEBwYXJhbVtpbl0gZGV2PGJyPg0KLSAqwqAgwqBQ
b2ludGVyIHRvIEV0aGVybmV0IGRldmljZS48YnI+DQotICogQHBhcmFtW291dF0gcG9saWN5X2lk
PGJyPg0KLSAqwqAgwqBQb2ludGVyIHRvIHBvbGljeSBpZDxicj4NCi0gKiBAcGFyYW1baW5dIGFj
dGlvbnM8YnI+DQotICrCoCDCoFBvaW50ZXIgdG8gbWV0ZXIgcG9saWN5IGFjdGlvbiBkZXRhaWwu
PGJyPg0KLSAqIEBwYXJhbVtvdXRdIGVycm9yPGJyPg0KLSAqwqAgwqBQb2ludGVyIHRvIHRoZSBl
cnJvciBzdHJ1Y3R1cmUuPGJyPg0KLSAqPGJyPg0KLSAqIEByZXR1cm48YnI+DQotICrCoCDCoDAg
b24gc3VjY2VzcywgYSBuZWdhdGl2ZSBlcnJubyB2YWx1ZSBvdGhlcndpc2UgYW5kIHJ0ZV9lcnJu
byBpcyBzZXQuPGJyPg0KLSAqLzxicj4NCi1zdGF0aWMgaW50PGJyPg0KLW1seDVfZmxvd19tZXRl
cl9wb2xpY3lfaHdzX2FkZChzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50MzJfdCBwb2xpY3lfaWQsPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHJ0ZV9tdHJfbWV0ZXJfcG9saWN5
X3BhcmFtcyAqcG9saWN5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN0cnVjdCBydGVfbXRyX2Vycm9yICplcnJvcik8YnI+DQotezxicj4NCi3CoCDCoCDCoCDCoHN0
cnVjdCBtbHg1X3ByaXYgKnByaXYgPSBkZXYtJmd0O2RhdGEtJmd0O2Rldl9wcml2YXRlOzxicj4N
Ci3CoCDCoCDCoCDCoHN0cnVjdCBtbHg1X2Zsb3dfbWV0ZXJfcG9saWN5ICptdHJfcG9saWN5ID0g
TlVMTDs8YnI+DQotwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uICphY3Q7
PGJyPg0KLcKgIMKgIMKgIMKgY29uc3Qgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9tZXRlciAqbXRy
Ozxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBtbHg1X2Zsb3dfbWV0ZXJfaW5mbyAqZm07PGJyPg0K
LcKgIMKgIMKgIMKgc3RydWN0IG1seDVfZmxvd19tZXRlcl9wb2xpY3kgKnBsYzs8YnI+DQotwqAg
wqAgwqAgwqB1aW50OF90IGRvbWFpbl9jb2xvciA9IE1MWDVfTVRSX0FMTF9ET01BSU5fQklUOzxi
cj4NCi3CoCDCoCDCoCDCoGJvb2wgaXNfcnNzID0gZmFsc2U7PGJyPg0KLcKgIMKgIMKgIMKgYm9v
bCBpc19oaWVyYXJjaHkgPSBmYWxzZTs8YnI+DQotwqAgwqAgwqAgwqBpbnQgaSwgajs8YnI+DQot
wqAgwqAgwqAgwqB1aW50MzJfdCBuYl9jb2xvcnMgPSAwOzxicj4NCi3CoCDCoCDCoCDCoHVpbnQz
Ml90IG5iX2Zsb3dzID0gMDs8YnI+DQotwqAgwqAgwqAgwqBpbnQgY29sb3I7PGJyPg0KLcKgIMKg
IMKgIMKgaW50IHJldDs8YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfcGF0dGVybl90
ZW1wbGF0ZV9hdHRyIHB0YSA9IHswfTs8YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3df
YWN0aW9uc190ZW1wbGF0ZV9hdHRyIGF0YSA9IHswfTs8YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3Qg
cnRlX2Zsb3dfdGVtcGxhdGVfdGFibGVfYXR0ciB0YSA9IHsgezB9LCAwIH07PGJyPg0KLcKgIMKg
IMKgIMKgc3RydWN0IHJ0ZV9mbG93X29wX2F0dHIgb3BfYXR0ciA9IHsgLnBvc3Rwb25lID0gMSB9
Ozxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBydGVfZmxvd19vcF9yZXN1bHQgcmVzdWx0W1JURV9D
T0xPUlMgKiBNTFg1X01UUl9ET01BSU5fTUFYXTs8YnI+DQotwqAgwqAgwqAgwqBjb25zdCB1aW50
MzJfdCBjb2xvcl9tYXNrID0gKFVJTlQzMl9DKDEpICZsdDsmbHQ7IE1MWDVfTVRSX0NPTE9SX0JJ
VFMpIC0gMTs8YnI+DQotwqAgwqAgwqAgwqBpbnQgY29sb3JfcmVnX2NfaWR4ID0gbWx4NV9mbG93
X2dldF9yZWdfaWQoZGV2LCBNTFg1X01UUl9DT0xPUiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
MCwgTlVMTCk7PGJyPg0KLcKgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X2l0ZW1fdGFnIHRhZ19z
cGVjID0gezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5kYXRhID0gMCw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAuaW5kZXggPSBjb2xvcl9yZWdfY19pZHg8YnI+DQotwqAgwqAg
wqAgwqB9Ozxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBydGVfZmxvd19pdGVtX3RhZyB0YWdfbWFz
ayA9IHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZGF0YSA9IGNvbG9yX21hc2ssPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmluZGV4ID0gMHhmZn07PGJyPg0KLcKgIMKgIMKg
IMKgc3RydWN0IHJ0ZV9mbG93X2l0ZW0gcGF0dGVybltdID0gezxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFswXSA9IHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAudHlwZSA9IChlbnVtIHJ0ZV9mbG93X2l0ZW1fdHlwZSk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNTFg1X1JURV9GTE9XX0lURU1fVFlQRV9U
QUcsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLnNwZWMgPSAmYW1w
O3RhZ19zcGVjLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5tYXNr
ID0gJmFtcDt0YWdfbWFzayw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9LDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFsxXSA9IHsgLnR5cGUgPSBSVEVfRkxPV19JVEVNX1RZUEVf
RU5EIH08YnI+DQotwqAgwqAgwqAgwqB9Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBpZiAobWx4
NV9od3NfYWN0aXZlKGRldikgJmFtcDsmYW1wOyAhbWx4NV9od19jdHhfdmFsaWRhdGUoZGV2LCBO
VUxMKSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLXJ0ZV9tdHJfZXJyb3Jf
c2V0KGVycm9yLCBFSU5WQUwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01UUl9FUlJPUl9UWVBFX1VOU1BFQ0lG
SUVELCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O25vbi10ZW1wbGF0ZSBmbG93IGVuZ2luZSB3YXMg
bm90IGNvbmZpZ3VyZWQmcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoGlmICghcHJpdi0mZ3Q7bXRy
X3BvbGljeV9hcnIpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIG1seDVfZmxv
d19tZXRlcl9wb2xpY3lfYWRkKGRldiwgcG9saWN5X2lkLCBwb2xpY3ksIGVycm9yKTs8YnI+DQot
wqAgwqAgwqAgwqBtdHJfcG9saWN5ID0gbWx4NV9mbG93X21ldGVyX3BvbGljeV9maW5kKGRldiwg
cG9saWN5X2lkLCBOVUxMKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAobXRyX3BvbGljeS0mZ3Q7aW5p
dGlhbGl6ZWQpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1ydGVfbXRyX2Vy
cm9yX3NldChlcnJvciwgRUVYSVNULDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFJURV9NVFJfRVJST1JfVFlQRV9NRVRFUl9QT0xJQ1lfSUQsPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwgJnF1b3Q7TWV0ZXIgcG9saWN5IGFscmVh
ZHkgZXhpc3RzLiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgaWYgKCFwb2xpY3kgfHw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAoIXBvbGljeS0mZ3Q7YWN0aW9uc1tSVEVfQ09MT1JfUkVEXSAmYW1w
OyZhbXA7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIXBvbGljeS0mZ3Q7YWN0aW9uc1tSVEVfQ09M
T1JfWUVMTE9XXSAmYW1wOyZhbXA7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIXBvbGljeS0mZ3Q7
YWN0aW9uc1tSVEVfQ09MT1JfR1JFRU5dKSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gLXJ0ZV9tdHJfZXJyb3Jfc2V0KGVycm9yLCBFSU5WQUwsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01U
Ul9FUlJPUl9UWVBFX01FVEVSX1BPTElDWSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCAmcXVvdDtNZXRlciBw
b2xpY3kgYWN0aW9ucyBhcmUgbm90IHZhbGlkLiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgaWYg
KHBvbGljeS0mZ3Q7YWN0aW9uc1tSVEVfQ09MT1JfUkVEXSA9PSBSVEVfRkxPV19BQ1RJT05fVFlQ
RV9FTkQpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbXRyX3BvbGljeS0mZ3Q7c2tpcF9y
ID0gMTs8YnI+DQotwqAgwqAgwqAgwqBpZiAocG9saWN5LSZndDthY3Rpb25zW1JURV9DT0xPUl9Z
RUxMT1ddID09IFJURV9GTE9XX0FDVElPTl9UWVBFX0VORCk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBtdHJfcG9saWN5LSZndDtza2lwX3kgPSAxOzxicj4NCi3CoCDCoCDCoCDCoGlmIChw
b2xpY3ktJmd0O2FjdGlvbnNbUlRFX0NPTE9SX0dSRUVOXSA9PSBSVEVfRkxPV19BQ1RJT05fVFlQ
RV9FTkQpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbXRyX3BvbGljeS0mZ3Q7c2tpcF9n
ID0gMTs8YnI+DQotwqAgwqAgwqAgwqBpZiAobXRyX3BvbGljeS0mZ3Q7c2tpcF9yICZhbXA7JmFt
cDsgbXRyX3BvbGljeS0mZ3Q7c2tpcF95ICZhbXA7JmFtcDsgbXRyX3BvbGljeS0mZ3Q7c2tpcF9n
KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtcnRlX210cl9lcnJvcl9zZXQo
ZXJyb3IsIEVOT1RTVVAsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01UUl9FUlJPUl9UWVBFX01FVEVSX1BPTElD
WV9JRCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBOVUxMLCAmcXVvdDtNZXRlciBwb2xpY3kgYWN0aW9ucyBhcmUgZW1w
dHkuJnF1b3Q7KTs8YnI+DQotwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgUlRFX0NPTE9S
UzsgaSsrKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYWN0ID0gcG9saWN5LSZndDth
Y3Rpb25zW2ldOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHdoaWxlIChhY3QgJmFtcDsm
YW1wOyBhY3QtJmd0O3R5cGUgIT0gUlRFX0ZMT1dfQUNUSU9OX1RZUEVfRU5EKSB7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3dpdGNoIChhY3QtJmd0O3R5cGUpIHs8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FD
VElPTl9UWVBFX1BPUlRfSUQ6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLyogZmFsbC10aHJvdWdoLiAqLzxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfUkVQUkVTRU5URURf
UE9SVDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBkb21haW5fY29sb3IgJmFtcDs9IH4oTUxYNV9NVFJfRE9NQUlOX0lOR1JFU1NfQklUIHw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBNTFg1X01UUl9ET01BSU5fRUdSRVNTX0JJVCk7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05f
VFlQRV9SU1M6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaXNfcnNzID0gdHJ1ZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAvKiBmYWxsLXRocm91Z2guICovPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9RVUVVRTo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkb21haW5f
Y29sb3IgJmFtcDs9IH4oTUxYNV9NVFJfRE9NQUlOX0VHUkVTU19CSVQgfDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoE1MWDVfTVRSX0RPTUFJTl9UUkFOU0ZFUl9CSVQpOzxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfTUVU
RVI6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aXNfaGllcmFyY2h5ID0gdHJ1ZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBtdHIgPSBhY3QtJmd0O2NvbmY7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm0gPSBtbHg1X2Zsb3dfbWV0ZXJfZmlu
ZChwcml2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG10ci0mZ3Q7bXRyX2lk
LCBOVUxMKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoIWZtKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtcnRlX210cl9lcnJvcl9zZXQoZXJyb3IsIEVJ
TlZBTCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBSVEVfTVRSX0VSUk9SX1RZUEVfTVRSX0lELCBOVUxM
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O01ldGVyIG5vdCBmb3VuZCBpbiBtZXRlciBoaWVy
YXJjaHkuJnF1b3Q7KTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBwbGMgPSBtbHg1X2Zsb3dfbWV0ZXJfcG9saWN5X2ZpbmQoZGV2LDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZtLSZndDtwb2xpY3lfaWQs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCk7PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTUxYNV9B
U1NFUlQocGxjKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBkb21haW5fY29sb3IgJmFtcDs9IE1MWDVfTVRSX0FMTF9ET01BSU5fQklUICZhbXA7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKHBsYy0mZ3Q7aW5ncmVzcyAmbHQ7Jmx0Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNTFg1X01UUl9ET01B
SU5fSU5HUkVTUyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZG9tYWluX2NvbG9yICZhbXA7PSBNTFg1X01UUl9BTExfRE9NQUlOX0JJVCAmYW1w
Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoChwbGMtJmd0O2VncmVzcyAmbHQ7Jmx0Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNTFg1X01UUl9ET01B
SU5fRUdSRVNTKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBkb21haW5fY29sb3IgJmFtcDs9IE1MWDVfTVRSX0FMTF9ET01BSU5fQklUICZhbXA7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKHBsYy0mZ3Q7dHJhbnNmZXIgJmx0OyZsdDs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTUxYNV9NVFJfRE9N
QUlOX1RSQU5TRkVSKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBicmVhazs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBkZWZhdWx0Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGJyZWFrOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhY3QrKzs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KLcKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDC
oGlmIChwcml2LSZndDtzaC0mZ3Q7Y29uZmlnLmR2X2Vzd19lbik8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBkb21haW5fY29sb3IgJmFtcDs9IH4oTUxYNV9NVFJfRE9NQUlOX0VHUkVTU19C
SVQgfDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoE1MWDVfTVRSX0RPTUFJTl9UUkFOU0ZFUl9CSVQpOzxicj4NCi3CoCDCoCDCoCDCoGVsc2U8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkb21haW5fY29sb3IgJmFtcDs9IH5NTFg1X01U
Ul9ET01BSU5fVFJBTlNGRVJfQklUOzxicj4NCi3CoCDCoCDCoCDCoGlmICghZG9tYWluX2NvbG9y
KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtcnRlX210cl9lcnJvcl9zZXQo
ZXJyb3IsIEVOT1RTVVAsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01UUl9FUlJPUl9UWVBFX01FVEVSX1BPTElD
WV9JRCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBOVUxMLCAmcXVvdDtNZXRlciBwb2xpY3kgZG9tYWlucyBhcmUgY29u
ZmxpY3RpbmcuJnF1b3Q7KTs8YnI+DQotwqAgwqAgwqAgwqBtdHJfcG9saWN5LSZndDtpc19yc3Mg
PSBpc19yc3M7PGJyPg0KLcKgIMKgIMKgIMKgbXRyX3BvbGljeS0mZ3Q7aW5ncmVzcyA9ICEhKGRv
bWFpbl9jb2xvciAmYW1wOyBNTFg1X01UUl9ET01BSU5fSU5HUkVTU19CSVQpOzxicj4NCi3CoCDC
oCDCoCDCoHB0YS5pbmdyZXNzID0gbXRyX3BvbGljeS0mZ3Q7aW5ncmVzczs8YnI+DQotwqAgwqAg
wqAgwqBtdHJfcG9saWN5LSZndDtlZ3Jlc3MgPSAhIShkb21haW5fY29sb3IgJmFtcDsgTUxYNV9N
VFJfRE9NQUlOX0VHUkVTU19CSVQpOzxicj4NCi3CoCDCoCDCoCDCoHB0YS5lZ3Jlc3MgPSBtdHJf
cG9saWN5LSZndDtlZ3Jlc3M7PGJyPg0KLcKgIMKgIMKgIMKgbXRyX3BvbGljeS0mZ3Q7dHJhbnNm
ZXIgPSAhIShkb21haW5fY29sb3IgJmFtcDsgTUxYNV9NVFJfRE9NQUlOX1RSQU5TRkVSX0JJVCk7
PGJyPg0KLcKgIMKgIMKgIMKgcHRhLnRyYW5zZmVyID0gbXRyX3BvbGljeS0mZ3Q7dHJhbnNmZXI7
PGJyPg0KLcKgIMKgIMKgIMKgbXRyX3BvbGljeS0mZ3Q7Z3JvdXAgPSBNTFg1X0ZMT1dfVEFCTEVf
SFdTX1BPTElDWSAtIHBvbGljeV9pZDs8YnI+DQotwqAgwqAgwqAgwqBtdHJfcG9saWN5LSZndDtp
c19oaWVyYXJjaHkgPSBpc19oaWVyYXJjaHk7PGJyPg0KLcKgIMKgIMKgIMKgbXRyX3BvbGljeS0m
Z3Q7aW5pdGlhbGl6ZWQgPSAxOzxicj4NCi3CoCDCoCDCoCDCoHJ0ZV9zcGlubG9ja19sb2NrKCZh
bXA7cHJpdi0mZ3Q7aHdfY3RybF9sb2NrKTs8YnI+DQotwqAgwqAgwqAgwqBtdHJfcG9saWN5LSZn
dDtod3NfaXRlbV90ZW1wbCA9PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2Zsb3df
cGF0dGVybl90ZW1wbGF0ZV9jcmVhdGUoZGV2LSZndDtkYXRhLSZndDtwb3J0X2lkLDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmYW1wO3B0YSwgcGF0dGVybiwgTlVMTCk7PGJyPg0KLcKgIMKgIMKgIMKg
aWYgKCFtdHJfcG9saWN5LSZndDtod3NfaXRlbV90ZW1wbCk8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBnb3RvIHBvbGljeV9hZGRfZXJyOzxicj4NCi3CoCDCoCDCoCDCoGZvciAoaSA9IDA7
IGkgJmx0OyBSVEVfQ09MT1JTOyBpKyspIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAobXRyX3BvbGljeS0mZ3Q7c2tpcF9nICZhbXA7JmFtcDsgaSA9PSBSVEVfQ09MT1JfR1JFRU4p
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG10cl9wb2xpY3ktJmd0O3NraXBfeSAmYW1wOyZh
bXA7IGkgPT0gUlRFX0NPTE9SX1lFTExPVyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobXRy
X3BvbGljeS0mZ3Q7c2tpcF9yICZhbXA7JmFtcDsgaSA9PSBSVEVfQ09MT1JfUkVEKTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnRpbnVlOzxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoG10cl9wb2xpY3ktJmd0O2h3c19hY3RfdGVtcGxbbmJfY29sb3JzXSA9
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2Zsb3dfYWN0aW9u
c190ZW1wbGF0ZV9jcmVhdGUoZGV2LSZndDtkYXRhLSZndDtwb3J0X2lkLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCZhbXA7YXRhLCBwb2xpY3ktJmd0O2FjdGlvbnNbaV0sPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcG9saWN5LSZndDthY3Rpb25zW2ldLCBOVUxMKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoIW10cl9wb2xpY3ktJmd0O2h3c19hY3RfdGVtcGxbbmJfY29sb3JzXSk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIHBvbGljeV9hZGRfZXJyOzxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5iX2NvbG9ycysrOzxicj4NCi3CoCDCoCDCoCDC
oH08YnI+DQotwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgTUxYNV9NVFJfRE9NQUlOX01B
WDsgaSsrKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWVtc2V0KCZhbXA7dGEsIDAs
IHNpemVvZih0YSkpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRhLm5iX2Zsb3dzID0g
UlRFX0NPTE9SUzs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0YS5mbG93X2F0dHIuZ3Jv
dXAgPSBtdHJfcG9saWN5LSZndDtncm91cDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAoaSA9PSBNTFg1X01UUl9ET01BSU5fSU5HUkVTUykgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmICghbXRyX3BvbGljeS0mZ3Q7aW5ncmVzcyk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0YS5mbG93X2F0dHIuaW5ncmVz
cyA9IDE7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIGlmIChpID09IE1MWDVf
TVRSX0RPTUFJTl9FR1JFU1MpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoIW10cl9wb2xpY3ktJmd0O2VncmVzcyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0YS5mbG93X2F0dHIuZWdyZXNzID0gMTs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB9IGVsc2UgaWYgKGkgPT0gTUxYNV9NVFJfRE9NQUlOX1RSQU5T
RkVSKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFtdHJf
cG9saWN5LSZndDt0cmFuc2Zlcik8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB0YS5mbG93X2F0dHIudHJhbnNmZXIgPSAxOzxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtdHJfcG9saWN5LSZndDto
d3NfZmxvd190YWJsZVtpXSA9PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcnRlX2Zsb3dfdGVtcGxhdGVfdGFibGVfY3JlYXRlKGRldi0mZ3Q7ZGF0YS0mZ3Q7cG9ydF9p
ZCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAmYW1wO3RhLCAmYW1wO210cl9wb2xpY3ktJmd0O2h3c19pdGVtX3RlbXBsLCAx
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG10cl9wb2xpY3ktJmd0O2h3c19hY3RfdGVtcGwsIG5iX2NvbG9ycyw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBOVUxMKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIW10cl9wb2xpY3ktJmd0
O2h3c19mbG93X3RhYmxlW2ldKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdvdG8gcG9saWN5X2FkZF9lcnI7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmJf
Y29sb3JzID0gMDs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGogPSAwOyBqICZs
dDsgUlRFX0NPTE9SUzsgaisrKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgKG10cl9wb2xpY3ktJmd0O3NraXBfZyAmYW1wOyZhbXA7IGogPT0gUlRFX0NPTE9S
X0dSRUVOKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGNvbnRpbnVlOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChtdHJfcG9saWN5LSZndDtza2lwX3kgJmFtcDsmYW1wOyBqID09IFJURV9DT0xPUl9ZRUxMT1cp
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29u
dGludWU7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG10cl9w
b2xpY3ktJmd0O3NraXBfciAmYW1wOyZhbXA7IGogPT0gUlRFX0NPTE9SX1JFRCk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb2xvciA9IHJ0ZV9jb2xfMl9t
bHg1X2NvbCgoZW51bSBydGVfY29sb3Ipaik7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdGFnX3NwZWMuZGF0YSA9IGNvbG9yOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoG10cl9wb2xpY3ktJmd0O2h3c19mbG93X3J1bGVbaV1bal0gPTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9m
bG93X2FzeW5jX2NyZWF0ZShkZXYtJmd0O2RhdGEtJmd0O3BvcnRfaWQsPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQ1RSTF9R
VUVVRV9JRChwcml2KSwgJmFtcDtvcF9hdHRyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG10cl9wb2xpY3ktJmd0O2h3c19m
bG93X3RhYmxlW2ldLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhdHRlcm4sIDAsIHBvbGljeS0mZ3Q7YWN0aW9uc1tqXSw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBuYl9jb2xvcnMsIE5VTEwsIE5VTEwpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmICghbXRyX3BvbGljeS0mZ3Q7aHdzX2Zsb3dfcnVsZVtpXVtqXSk8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3Rv
IHBvbGljeV9hZGRfZXJyOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oG5iX2NvbG9ycysrOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5i
X2Zsb3dzKys7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldCA9IHJ0ZV9mbG93X3B1c2goZGV2LSZndDtkYXRhLSZndDtwb3J0X2lk
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoENUUkxfUVVFVUVfSUQocHJpdiksIE5VTEwpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChyZXQgJmx0OyAwKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdvdG8gcG9saWN5X2FkZF9lcnI7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgd2hp
bGUgKG5iX2Zsb3dzKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0ID0gcnRlX2Zsb3dfcHVsbChkZXYtJmd0O2RhdGEtJmd0O3BvcnRfaWQsPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgQ1RSTF9RVUVVRV9JRChwcml2KSwgcmVzdWx0LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5iX2Zsb3dzLCBO
VUxMKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0ICZs
dDsgMCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBnb3RvIHBvbGljeV9hZGRfZXJyOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGZvciAoaiA9IDA7IGogJmx0OyByZXQ7IGorKykgezxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXN1bHRbal0uc3RhdHVzID09
IFJURV9GTE9XX09QX0VSUk9SKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gcG9saWN5X2FkZF9lcnI7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoG5iX2Zsb3dzIC09IHJldDs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9PGJyPg0KLcKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDCoHJ0ZV9zcGlubG9j
a191bmxvY2soJmFtcDtwcml2LSZndDtod19jdHJsX2xvY2spOzxicj4NCi3CoCDCoCDCoCDCoHJl
dHVybiAwOzxicj4NCi1wb2xpY3lfYWRkX2Vycjo8YnI+DQotwqAgwqAgwqAgwqBydGVfc3Bpbmxv
Y2tfdW5sb2NrKCZhbXA7cHJpdi0mZ3Q7aHdfY3RybF9sb2NrKTs8YnI+DQotwqAgwqAgwqAgwqBy
ZXQgPSBtbHg1X2Zsb3dfbWV0ZXJfcG9saWN5X2h3c19kZWxldGUoZGV2LCBwb2xpY3lfaWQsIGVy
cm9yKTs8YnI+DQotwqAgwqAgwqAgwqBtZW1zZXQobXRyX3BvbGljeSwgMCwgc2l6ZW9mKHN0cnVj
dCBtbHg1X2Zsb3dfbWV0ZXJfcG9saWN5KSk7PGJyPg0KLcKgIMKgIMKgIMKgaWYgKHJldCk8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCi3CoCDCoCDCoCDCoHJl
dHVybiAtcnRlX210cl9lcnJvcl9zZXQoZXJyb3IsIEVOT1RTVVAsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01UUl9FUlJPUl9UWVBF
X1VOU1BFQ0lGSUVELDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoE5VTEwsICZxdW90O0ZhaWxlZCB0byBjcmVhdGUgbWV0ZXIgcG9saWN5LiZx
dW90Oyk7PGJyPg0KLX08YnI+DQotI2VuZGlmPGJyPg0KwqAvKio8YnI+DQrCoCAqIENoZWNrIG1l
dGVyIHZhbGlkYXRpb24uPGJyPg0KwqAgKjxicj4NCkBAIC0yMjM5LDEwNSArMTg2OCw2IEBAIG1s
eDVfZmxvd19tZXRlcl9jcmVhdGUoc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsIHVpbnQzMl90IG1l
dGVyX2lkLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5VTEwsICZxdW90O0ZhaWxlZCB0
byBjcmVhdGUgZGV2eCBtZXRlci4mcXVvdDspOzxicj4NCsKgfTxicj4NCjxicj4NCi0jaWYgZGVm
aW5lZChIQVZFX01MWDVfSFdTX1NVUFBPUlQpPGJyPg0KLS8qKjxicj4NCi0gKiBDcmVhdGUgbWV0
ZXIgcnVsZXMuPGJyPg0KLSAqPGJyPg0KLSAqIEBwYXJhbVtpbl0gZGV2PGJyPg0KLSAqwqAgwqBQ
b2ludGVyIHRvIEV0aGVybmV0IGRldmljZS48YnI+DQotICogQHBhcmFtW2luXSBtZXRlcl9pZDxi
cj4NCi0gKsKgIMKgTWV0ZXIgaWQuPGJyPg0KLSAqIEBwYXJhbVtpbl0gcGFyYW1zPGJyPg0KLSAq
wqAgwqBQb2ludGVyIHRvIHJ0ZSBtZXRlciBwYXJhbWV0ZXJzLjxicj4NCi0gKiBAcGFyYW1baW5d
IHNoYXJlZDxicj4NCi0gKsKgIMKgTWV0ZXIgc2hhcmVkIHdpdGggb3RoZXIgZmxvdyBvciBub3Qu
PGJyPg0KLSAqIEBwYXJhbVtvdXRdIGVycm9yPGJyPg0KLSAqwqAgwqBQb2ludGVyIHRvIHJ0ZSBt
ZXRlciBlcnJvciBzdHJ1Y3R1cmUuPGJyPg0KLSAqPGJyPg0KLSAqIEByZXR1cm48YnI+DQotICrC
oCDCoDAgb24gc3VjY2VzcywgYSBuZWdhdGl2ZSBlcnJubyB2YWx1ZSBvdGhlcndpc2UgYW5kIHJ0
ZV9lcnJubyBpcyBzZXQuPGJyPg0KLSAqLzxicj4NCi1zdGF0aWMgaW50PGJyPg0KLW1seDVfZmxv
d19tZXRlcl9od3NfY3JlYXRlKHN0cnVjdCBydGVfZXRoX2RldiAqZGV2LCB1aW50MzJfdCBtZXRl
cl9pZCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IHJ0ZV9t
dHJfcGFyYW1zICpwYXJhbXMsIGludCBzaGFyZWQsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHN0cnVjdCBydGVfbXRyX2Vycm9yICplcnJvcik8YnI+DQotezxicj4NCi3C
oCDCoCDCoCDCoHN0cnVjdCBtbHg1X3ByaXYgKnByaXYgPSBkZXYtJmd0O2RhdGEtJmd0O2Rldl9w
cml2YXRlOzxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBtbHg1X2Zsb3dfbWV0ZXJfcHJvZmlsZSAq
cHJvZmlsZTs8YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3QgbWx4NV9mbG93X21ldGVyX2luZm8gKmZt
Ozxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBtbHg1X2Zsb3dfbWV0ZXJfcG9saWN5ICpwb2xpY3kg
PSBOVUxMOzxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBtbHg1X2Fzb19tdHIgKmFzb19tdHI7PGJy
Pg0KLcKgIMKgIMKgIMKgc3RydWN0IG1seDVfaHdfcV9qb2IgKmpvYjs8YnI+DQotwqAgwqAgwqAg
wqBpbnQgcmV0Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBpZiAobWx4NV9od3NfYWN0aXZlKGRl
dikgJmFtcDsmYW1wOyAhbWx4NV9od19jdHhfdmFsaWRhdGUoZGV2LCBOVUxMKSk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLXJ0ZV9tdHJfZXJyb3Jfc2V0KGVycm9yLCBFSU5W
QUwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgUlRFX01UUl9FUlJPUl9UWVBFX1VOU1BFQ0lGSUVELCBOVUxMLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCZxdW90O25vbi10ZW1wbGF0ZSBmbG93IGVuZ2luZSB3YXMgbm90IGNvbmZpZ3VyZWQm
cXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoGlmICghcHJpdi0mZ3Q7bXRyX3Byb2ZpbGVfYXJyIHx8
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIXByaXYtJmd0O210cl9wb2xpY3lfYXJyIHx8PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIXByaXYtJmd0O210cl9idWxrLmFzbyk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gLXJ0ZV9tdHJfZXJyb3Jfc2V0KGVycm9yLCBFTk9UU1VQLDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9NVFJfRVJST1JfVFlQ
RV9VTlNQRUNJRklFRCwgTlVMTCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmcXVvdDtNZXRlciBidWxrIGFycmF5IGlzIG5vdCBhbGxvY2F0ZWQuJnF1b3Q7KTs8YnI+
DQotwqAgwqAgwqAgwqAvKiBNZXRlciBwcm9maWxlIG11c3QgZXhpc3QuICovPGJyPg0KLcKgIMKg
IMKgIMKgcHJvZmlsZSA9IG1seDVfZmxvd19tZXRlcl9wcm9maWxlX2ZpbmQocHJpdiwgcGFyYW1z
LSZndDttZXRlcl9wcm9maWxlX2lkKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAoIXByb2ZpbGUtJmd0
O2luaXRpYWxpemVkKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtcnRlX210
cl9lcnJvcl9zZXQoZXJyb3IsIEVOT0VOVCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBSVEVfTVRSX0VSUk9SX1RZUEVfTUVURVJfUFJPRklMRV9JRCw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCAmcXVvdDtNZXRlciBwcm9maWxl
IGlkIG5vdCB2YWxpZC4mcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoC8qIE1ldGVyIHBvbGljeSBt
dXN0IGV4aXN0LiAqLzxicj4NCi3CoCDCoCDCoCDCoHBvbGljeSA9IG1seDVfZmxvd19tZXRlcl9w
b2xpY3lfZmluZChkZXYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cGFyYW1zLSZndDttZXRlcl9wb2xpY3lfaWQsIE5VTEwpOzxicj4NCi3CoCDCoCDCoCDCoGlmICgh
cG9saWN5LSZndDtpbml0aWFsaXplZCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gLXJ0ZV9tdHJfZXJyb3Jfc2V0KGVycm9yLCBFTk9FTlQsPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01UUl9FUlJPUl9UWVBFX01FVEVSX1BPTElDWV9JRCw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCAmcXVvdDtNZXRl
ciBwb2xpY3kgaWQgbm90IHZhbGlkLiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgLyogTWV0ZXIg
SUQgbXVzdCBiZSB2YWxpZC4gKi88YnI+DQotwqAgwqAgwqAgwqBpZiAobWV0ZXJfaWQgJmd0Oz0g
cHJpdi0mZ3Q7bXRyX2NvbmZpZy5uYl9tZXRlcnMpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIC1ydGVfbXRyX2Vycm9yX3NldChlcnJvciwgRUlOVkFMLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9NVFJfRVJST1JfVFlQRV9NVFJfSUQsPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwgJnF1b3Q7TWV0ZXIg
aWQgbm90IHZhbGlkLiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgLyogRmluZCBBU08gb2JqZWN0
LiAqLzxicj4NCi3CoCDCoCDCoCDCoGFzb19tdHIgPSBtbHg1X2Fzb19tZXRlcl9ieV9pZHgocHJp
diwgbWV0ZXJfaWQpOzxicj4NCi3CoCDCoCDCoCDCoGZtID0gJmFtcDthc29fbXRyLSZndDtmbTs8
YnI+DQotwqAgwqAgwqAgwqBpZiAoZm0tJmd0O2luaXRpYWxpemVkKTxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiAtcnRlX210cl9lcnJvcl9zZXQoZXJyb3IsIEVOT0VOVCw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBSVEVfTVRSX0VSUk9SX1RZUEVfTVRSX0lELDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsICZxdW90
O01ldGVyIG9iamVjdCBhbHJlYWR5IGV4aXN0cy4mcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoC8q
IEZpbGwgdGhlIGZsb3cgbWV0ZXIgcGFyYW1ldGVycy4gKi88YnI+DQotwqAgwqAgwqAgwqBmbS0m
Z3Q7bWV0ZXJfaWQgPSBtZXRlcl9pZDs8YnI+DQotwqAgwqAgwqAgwqBmbS0mZ3Q7cG9saWN5X2lk
ID0gcGFyYW1zLSZndDttZXRlcl9wb2xpY3lfaWQ7PGJyPg0KLcKgIMKgIMKgIMKgZm0tJmd0O3By
b2ZpbGUgPSBwcm9maWxlOzxicj4NCi3CoCDCoCDCoCDCoGZtLSZndDttZXRlcl9vZmZzZXQgPSBt
ZXRlcl9pZDs8YnI+DQotwqAgwqAgwqAgwqBmbS0mZ3Q7Z3JvdXAgPSBwb2xpY3ktJmd0O2dyb3Vw
Ozxicj4NCi3CoCDCoCDCoCDCoC8qIEFkZCB0byB0aGUgZmxvdyBtZXRlciBsaXN0LiAqLzxicj4N
Ci3CoCDCoCDCoCDCoGZtLSZndDthY3RpdmVfc3RhdGUgPSAxOyAvKiBDb25maWcgbWV0ZXIgc3Rh
cnRzIGFzIGFjdGl2ZS4gKi88YnI+DQotwqAgwqAgwqAgwqBmbS0mZ3Q7aXNfZW5hYmxlID0gcGFy
YW1zLSZndDttZXRlcl9lbmFibGU7PGJyPg0KLcKgIMKgIMKgIMKgZm0tJmd0O3NoYXJlZCA9ICEh
c2hhcmVkOzxicj4NCi3CoCDCoCDCoCDCoGZtLSZndDtpbml0aWFsaXplZCA9IDE7PGJyPg0KLcKg
IMKgIMKgIMKgLyogVXBkYXRlIEFTTyBmbG93IG1ldGVyIGJ5IHdxZS4gKi88YnI+DQotwqAgwqAg
wqAgwqBqb2IgPSBtbHg1X2Zsb3dfYWN0aW9uX2pvYl9pbml0KHByaXYsIE1MWDVfSFdfSU5WX1FV
RVVFLCBOVUxMLCBOVUxMLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIE1MWDVfSFdfUV9KT0JfVFlQRV9DUkVBVEUs
IE5VTEwpOzxicj4NCi3CoCDCoCDCoCDCoGlmICgham9iKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiAtcnRlX210cl9lcnJvcl9zZXQoZXJyb3IsIEVOT01FTSw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBSVEVfTVRSX0VSUk9SX1RZUEVfTVRSX0lELDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsICZxdW90O05vIGpv
YiBjb250ZXh0LiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgcmV0ID0gbWx4NV9hc29fbWV0ZXJf
dXBkYXRlX2J5X3dxZShwcml2LCBNTFg1X0hXX0lOVl9RVUVVRSwgYXNvX210ciw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJmFtcDtwcml2LSZndDttdHJfYnVsaywgam9iLCB0cnVlKTs8YnI+DQotwqAgwqAgwqAgwqBp
ZiAocmV0KSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmxvd19od19qb2JfcHV0KHBy
aXYsIGpvYiwgQ1RSTF9RVUVVRV9JRChwcml2KSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIC1ydGVfbXRyX2Vycm9yX3NldChlcnJvciwgRU5PVFNVUCw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBS
VEVfTVRSX0VSUk9SX1RZUEVfVU5TUEVDSUZJRUQsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCwgJnF1b3Q7RmFp
bGVkIHRvIGNyZWF0ZSBkZXZ4IG1ldGVyLiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgfTxicj4N
Ci3CoCDCoCDCoCDCoGZtLSZndDthY3RpdmVfc3RhdGUgPSBwYXJhbXMtJmd0O21ldGVyX2VuYWJs
ZTs8YnI+DQotwqAgwqAgwqAgwqBydGVfYXRvbWljX2ZldGNoX2FkZF9leHBsaWNpdCgmYW1wO2Zt
LSZndDtwcm9maWxlLSZndDtyZWZfY250LCAxLCBydGVfbWVtb3J5X29yZGVyX3JlbGF4ZWQpOzxi
cj4NCi3CoCDCoCDCoCDCoHJ0ZV9hdG9taWNfZmV0Y2hfYWRkX2V4cGxpY2l0KCZhbXA7cG9saWN5
LSZndDtyZWZfY250LCAxLCBydGVfbWVtb3J5X29yZGVyX3JlbGF4ZWQpOzxicj4NCi3CoCDCoCDC
oCDCoHJldHVybiAwOzxicj4NCi19PGJyPg0KLSNlbmRpZjxicj4NCi08YnI+DQrCoHN0YXRpYyBp
bnQ8YnI+DQrCoG1seDVfZmxvd19tZXRlcl9wYXJhbXNfZmx1c2goc3RydWN0IHJ0ZV9ldGhfZGV2
ICpkZXYsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IG1s
eDVfZmxvd19tZXRlcl9pbmZvICpmbSw8YnI+DQpAQCAtMjQ0NCw1OCArMTk3NCw2IEBAIG1seDVf
Zmxvd19tZXRlcl9kZXN0cm95KHN0cnVjdCBydGVfZXRoX2RldiAqZGV2LCB1aW50MzJfdCBtZXRl
cl9pZCw8YnI+DQrCoCDCoCDCoCDCoCByZXR1cm4gMDs8YnI+DQrCoH08YnI+DQo8YnI+DQotLyoq
PGJyPg0KLSAqIERlc3Ryb3kgbWV0ZXIgcnVsZXMuPGJyPg0KLSAqPGJyPg0KLSAqIEBwYXJhbVtp
bl0gZGV2PGJyPg0KLSAqwqAgwqBQb2ludGVyIHRvIEV0aGVybmV0IGRldmljZS48YnI+DQotICog
QHBhcmFtW2luXSBtZXRlcl9pZDxicj4NCi0gKsKgIMKgTWV0ZXIgaWQuPGJyPg0KLSAqIEBwYXJh
bVtvdXRdIGVycm9yPGJyPg0KLSAqwqAgwqBQb2ludGVyIHRvIHJ0ZSBtZXRlciBlcnJvciBzdHJ1
Y3R1cmUuPGJyPg0KLSAqPGJyPg0KLSAqIEByZXR1cm48YnI+DQotICrCoCDCoDAgb24gc3VjY2Vz
cywgYSBuZWdhdGl2ZSBlcnJubyB2YWx1ZSBvdGhlcndpc2UgYW5kIHJ0ZV9lcnJubyBpcyBzZXQu
PGJyPg0KLSAqLzxicj4NCi1zdGF0aWMgaW50PGJyPg0KLW1seDVfZmxvd19tZXRlcl9od3NfZGVz
dHJveShzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiwgdWludDMyX3QgbWV0ZXJfaWQsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHJ0ZV9tdHJfZXJyb3IgKmVy
cm9yKTxicj4NCi17PGJyPg0KLcKgIMKgIMKgIMKgc3RydWN0IG1seDVfcHJpdiAqcHJpdiA9IGRl
di0mZ3Q7ZGF0YS0mZ3Q7ZGV2X3ByaXZhdGU7PGJyPg0KLcKgIMKgIMKgIMKgc3RydWN0IG1seDVf
YXNvX210ciAqYXNvX210cjs8YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3QgbWx4NV9mbG93X21ldGVy
X2luZm8gKmZtOzxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBtbHg1X2Zsb3dfbWV0ZXJfcG9saWN5
ICpwb2xpY3k7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoGlmICghcHJpdi0mZ3Q7bXRyX3Byb2Zp
bGVfYXJyIHx8PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIXByaXYtJmd0O210cl9wb2xpY3lfYXJy
IHx8PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIXByaXYtJmd0O210cl9idWxrLmFzbyk8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLXJ0ZV9tdHJfZXJyb3Jfc2V0KGVycm9yLCBF
Tk9UU1VQLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9NVFJf
RVJST1JfVFlQRV9NRVRFUl9QT0xJQ1ksIE5VTEwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgJnF1b3Q7TWV0ZXIgYnVsayBhcnJheSBpcyBub3QgYWxsb2NhdGVkLiZx
dW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgLyogRmluZCBBU08gb2JqZWN0LiAqLzxicj4NCi3CoCDC
oCDCoCDCoGFzb19tdHIgPSBtbHg1X2Fzb19tZXRlcl9ieV9pZHgocHJpdiwgbWV0ZXJfaWQpOzxi
cj4NCi3CoCDCoCDCoCDCoGZtID0gJmFtcDthc29fbXRyLSZndDtmbTs8YnI+DQotwqAgwqAgwqAg
wqBpZiAoIWZtLSZndDtpbml0aWFsaXplZCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gLXJ0ZV9tdHJfZXJyb3Jfc2V0KGVycm9yLCBFTk9FTlQsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01U
Ul9FUlJPUl9UWVBFX01UUl9JRCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCAmcXVvdDtNZXRlciBvYmplY3Qg
aWQgbm90IHZhbGlkLiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgLyogTWV0ZXIgb2JqZWN0IG11
c3Qgbm90IGhhdmUgYW55IG93bmVyLiAqLzxicj4NCi3CoCDCoCDCoCDCoGlmIChmbS0mZ3Q7cmVm
X2NudCAmZ3Q7IDApPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1ydGVfbXRy
X2Vycm9yX3NldChlcnJvciwgRUJVU1ksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX01UUl9FUlJPUl9UWVBFX1VO
U1BFQ0lGSUVELDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsICZxdW90O01ldGVyIG9iamVjdCBpcyBiZWluZyB1
c2VkLiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgLyogRGVzdHJveSB0aGUgbWV0ZXIgcHJvZmls
ZS4gKi88YnI+DQotwqAgwqAgwqAgwqBydGVfYXRvbWljX2ZldGNoX3N1Yl9leHBsaWNpdCgmYW1w
O2ZtLSZndDtwcm9maWxlLSZndDtyZWZfY250LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDEsIHJ0ZV9t
ZW1vcnlfb3JkZXJfcmVsYXhlZCk7PGJyPg0KLcKgIMKgIMKgIMKgLyogRGVzdHJveSB0aGUgbWV0
ZXIgcG9saWN5LiAqLzxicj4NCi3CoCDCoCDCoCDCoHBvbGljeSA9IG1seDVfZmxvd19tZXRlcl9w
b2xpY3lfZmluZChkZXYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Zm0tJmd0O3BvbGljeV9pZCwgTlVMTCk7PGJyPg0KLcKgIMKgIMKgIMKgcnRlX2F0b21pY19mZXRj
aF9zdWJfZXhwbGljaXQoJmFtcDtwb2xpY3ktJmd0O3JlZl9jbnQsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgMSwgcnRlX21lbW9yeV9vcmRlcl9yZWxheGVkKTs8YnI+DQotwqAgwqAgwqAgwqBtZW1zZXQo
Zm0sIDAsIHNpemVvZihzdHJ1Y3QgbWx4NV9mbG93X21ldGVyX2luZm8pKTs8YnI+DQotwqAgwqAg
wqAgwqByZXR1cm4gMDs8YnI+DQotfTxicj4NCi08YnI+DQrCoC8qKjxicj4NCsKgICogTW9kaWZ5
IG1ldGVyIHN0YXRlLjxicj4NCsKgICo8YnI+DQpAQCAtMjgzNSwxNCArMjMxMyw2IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcnRlX210cl9vcHMgbWx4NV9mbG93X210cl9od3Nfb3BzID0gezxicj4N
CsKgIMKgIMKgIMKgIC5tZXRlcl9wcm9maWxlX2FkZCA9IG1seDVfZmxvd19tZXRlcl9wcm9maWxl
X2h3c19hZGQsPGJyPg0KwqAgwqAgwqAgwqAgLm1ldGVyX3Byb2ZpbGVfZGVsZXRlID0gbWx4NV9m
bG93X21ldGVyX3Byb2ZpbGVfaHdzX2RlbGV0ZSw8YnI+DQrCoCDCoCDCoCDCoCAubWV0ZXJfcHJv
ZmlsZV9nZXQgPSBtbHg1X2Zsb3dfbWV0ZXJfcHJvZmlsZV9nZXQsPGJyPg0KLcKgIMKgIMKgIMKg
Lm1ldGVyX3BvbGljeV92YWxpZGF0ZSA9IG1seDVfZmxvd19tZXRlcl9wb2xpY3lfaHdzX3ZhbGlk
YXRlLDxicj4NCi3CoCDCoCDCoCDCoC5tZXRlcl9wb2xpY3lfYWRkID0gbWx4NV9mbG93X21ldGVy
X3BvbGljeV9od3NfYWRkLDxicj4NCi3CoCDCoCDCoCDCoC5tZXRlcl9wb2xpY3lfZGVsZXRlID0g
bWx4NV9mbG93X21ldGVyX3BvbGljeV9od3NfZGVsZXRlLDxicj4NCi3CoCDCoCDCoCDCoC5tZXRl
cl9wb2xpY3lfZ2V0ID0gbWx4NV9mbG93X21ldGVyX3BvbGljeV9nZXQsPGJyPg0KLcKgIMKgIMKg
IMKgLmNyZWF0ZSA9IG1seDVfZmxvd19tZXRlcl9od3NfY3JlYXRlLDxicj4NCi3CoCDCoCDCoCDC
oC5kZXN0cm95ID0gbWx4NV9mbG93X21ldGVyX2h3c19kZXN0cm95LDxicj4NCi3CoCDCoCDCoCDC
oC5tZXRlcl9lbmFibGUgPSBtbHg1X2Zsb3dfbWV0ZXJfZW5hYmxlLDxicj4NCi3CoCDCoCDCoCDC
oC5tZXRlcl9kaXNhYmxlID0gbWx4NV9mbG93X21ldGVyX2Rpc2FibGUsPGJyPg0KwqAgwqAgwqAg
wqAgLm1ldGVyX3Byb2ZpbGVfdXBkYXRlID0gbWx4NV9mbG93X21ldGVyX3Byb2ZpbGVfdXBkYXRl
LDxicj4NCsKgIMKgIMKgIMKgIC5tZXRlcl9kc2NwX3RhYmxlX3VwZGF0ZSA9IE5VTEwsPGJyPg0K
wqAgwqAgwqAgwqAgLnN0YXRzX3VwZGF0ZSA9IE5VTEwsPGJyPg0KQEAgLTMyODYsMTQgKzI3NTYs
NiBAQCBtbHg1X2Zsb3dfbWV0ZXJfZmx1c2goc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsIHN0cnVj
dCBydGVfbXRyX2Vycm9yICplcnJvcik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCAmcXVvdDtNVFIgb2JqZWN0IG1ldGVyIHByb2ZpbGUg
aW52YWxpZC4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDC
oCDCoCDCoCB9PGJyPg0KLcKgIMKgIMKgIMKgaWYgKHByaXYtJmd0O210cl9idWxrLmFzbykgezxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBwcml2LSZndDtt
dHJfY29uZmlnLm5iX21ldGVyczsgaSsrKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYXNvX210ciA9IG1seDVfYXNvX21ldGVyX2J5X2lkeChwcml2LCBpKTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmbSA9ICZhbXA7YXNvX210ci0m
Z3Q7Zm07PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGZtLSZn
dDtpbml0aWFsaXplZCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBtbHg1X2Zsb3dfbWV0ZXJfaHdzX2Rlc3Ryb3koZGV2LCBpLCBlcnJvcik7PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQrCoCDC
oCDCoCDCoCBpZiAocHJpdi0mZ3Q7cG9saWN5X2lkeF90YmwpIHs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBNTFg1X0wzVF9GT1JFQUNIKHByaXYtJmd0O3BvbGljeV9pZHhfdGJsLCBpLCBl
bnRyeSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBvbGljeV9p
ZHggPSAqKHVpbnQzMl90ICopZW50cnk7PGJyPg0KQEAgLTMzMTksMjAgKzI3ODEsNiBAQCBtbHg1
X2Zsb3dfbWV0ZXJfZmx1c2goc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsIHN0cnVjdCBydGVfbXRy
X2Vycm9yICplcnJvcik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtbHg1X2wzdF9kZXN0
cm95KHByaXYtJmd0O3BvbGljeV9pZHhfdGJsKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBwcml2LSZndDtwb2xpY3lfaWR4X3RibCA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4N
Ci0jaWYgZGVmaW5lZChIQVZFX01MWDVfSFdTX1NVUFBPUlQpPGJyPg0KLcKgIMKgIMKgIMKgaWYg
KHByaXYtJmd0O210cl9wb2xpY3lfYXJyKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3RydWN0IG1seDVfZmxvd19tZXRlcl9wb2xpY3kgKnBvbGljeTs8YnI+DQotPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IHByaXYtJmd0O210cl9jb25maWcu
bmJfbWV0ZXJfcG9saWNpZXM7IGkrKykgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHBvbGljeSA9IG1seDVfZmxvd19tZXRlcl9wb2xpY3lfZmluZChkZXYsIGksPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7cG9saWN5X2lkeCk7PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHBvbGljeS0mZ3Q7aW5p
dGlhbGl6ZWQpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBtbHg1X2Zsb3dfbWV0ZXJfcG9saWN5X2h3c19kZWxldGUoZGV2LCBpLDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm9yKTs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfTxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQotI2VuZGlmPGJyPg0KwqAgwqAgwqAgwqAg
aWYgKHByaXYtJmd0O210cl9wcm9maWxlX3RibCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIE1MWDVfTDNUX0ZPUkVBQ0gocHJpdi0mZ3Q7bXRyX3Byb2ZpbGVfdGJsLCBpLCBlbnRyeSkg
ezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZtcCA9IGVudHJ5Ozxi
cj4NCi0tIDxicj4NCjIuNDguMTxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj4NCg==
--00000000000013f26a063455fd3c--
