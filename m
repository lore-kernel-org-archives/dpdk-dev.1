Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA7D58E73
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 08:05:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AF3040BA5;
	Mon,  2 Mar 2026 09:05:43 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id AA4FC4028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 00:36:39 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b8f8d80faebso787226966b.1
 for <dev@dpdk.org>; Sun, 01 Mar 2026 15:36:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772408199; cv=none;
 d=google.com; s=arc-20240605;
 b=ZXS6y3tqi42Li5+wc5miJxZuxVHJSOIfL/B0VDBpiTRNxh9e8mHT/BvU09M/vAUMJF
 rPzDS1+jORap7tRuCsYIgKtItySrqbY3r6DFdYC0XwLqr9dYDrP2lDDFHOpoz9JWz1wt
 VoKjzTyEvfOE46lg88tE4F8tYaw+4fWA0Gd/8u/4dSOnHWFS00tU/Kru7iKT7vCfKGS8
 ys4Gq7ix2CabHIPH+ImDNie8keUJrAxyegLkZtLBJA9Q+znkad4YrYfSxNfTjoi0L+LA
 9nDwkzLOcdnW19iy6LesXcUvLEOp56YWlnu6iIwXIwqkkePEq+Y+RbzJMrLsg8+ceiEt
 0Jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hy7SAN5MqZoCI78rSs+ZJZDUgB8bDKCh/7gCparc3YM=;
 fh=8oGxs2oF7z9SqOmD6xCfa+YvejyAOOsO/9wX54LOipk=;
 b=UXamfEjjzaY3H744sGy74xWtKW2LC8uVthb8hTumu+Nrm50q0uWY8fCJgndvlUew8v
 GlkoFiBfEBen9oZdhU82/VPxie+mRPghW+5ZImuRDNnsojaKkzVn88jC3+RvUihi9ijA
 9ywLBvGYNrggLqHwhJm0ujbKDEjSLV+B/pLEpcQxIyivZ+Bw5iAM7Tl95gNOBHbTL3Ag
 AIZvvJDg8CV3Wp0YQH8uzsuygegmx5Ky1EELtzBHRE64Hd3eZ7ozn/ehO+6B0A/XjUuO
 1G3WBldNQXJKaczASeb1sd3Ajmst2DbcmI7zRsYp11+VLHvAtPp/OUIDnp+0aUsARVNg
 jIIg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772408199; x=1773012999; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hy7SAN5MqZoCI78rSs+ZJZDUgB8bDKCh/7gCparc3YM=;
 b=CMOwk0w+SQIF/B6GVteptYwgKmnbYHBETgviW/lQd/m/RibqggePJDa0QrnBqos5tJ
 fnhSHq/gVksVhBakyWcO7r/V+bpoh6ro583htRmV76WmIhge4i2S4z+kbJN0eG7+3Wpz
 1Z6ERyLj2dTR2CK69qHsUPOoPklhVzfQ+qDXqDEeLfs1XNfNV9e8GqABPGHHtyeddfkL
 erJ5w37u9ROxY9sOY76SfSQNFPHrN0vDa+Q2xJgNL+RQ/2o+iRtoshWKN54loA/aFA6q
 5SFMPok4MWhXYbzU9xXw9gOXT0rR+5soc00VhPq0I6dGL8diizqLskuAVT2wE/Cq1qPz
 YTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772408199; x=1773012999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hy7SAN5MqZoCI78rSs+ZJZDUgB8bDKCh/7gCparc3YM=;
 b=wetVEWLhAYALKe5tsm+fVpiA9ED+vnz5Pgls3dhN7swqgLwSdFVWuLYEWec3fYaCQr
 zrgFgJr8guN71PmrmQY/zC9HVHa+htEM586NJXWmVEjcXZs+KjrnvnEch8bT2gutKbvK
 HpcMqGj0Ly4jApOssyw7yydXaT1Wl5pR2Bm8LdPX73+DczDuOjlaXYYE1zhwjWXawo7r
 jImf7zkOZGQfE87aDgtaQwcb/Yq8aL/gS1xJlkgAbvrlJMebcaQ1MkyYZL2uYAH5ijUR
 pH1vOgfUhqWerMCq7U6ge3kYdJBhnft37U/h5x5ql3EQMQVx5fHAL39KW+7Nj/CvbBV9
 sbfg==
X-Gm-Message-State: AOJu0YzOZLpM8HiLpZIyJdq1Puavhzq7hmkOjW0daL25l1mWKL3q1XTd
 LFLgkyHNsLtHgKMpmTuWJCondE5ndtCr581VdZZ8X9BcLMXotac+syfXutebySthafSvg2LmfJI
 UtGa3xii86mtnPjSPtfVFq4cSrcm4uOXKuMWf4MA=
X-Gm-Gg: ATEYQzwLBjGoN5XMBIjixsKimZQ98JVzju8X1Pj8rClqcA1wsM3qCaBjdoO1V8B2jdF
 pJj+bJbkGH2Lsdqh/D6yJV6DocDRHDJf6YhcGjT9RyGxtiPXks/yJ0TFJYCzyx7lubj0aa6j7LN
 Q/AINKQ2J2Gzg3nwkMhaL7vcqqP92Fbg8mSXjZ1DVb+f+bFeOyxZPuItnrZq5r0lHfKYDjH9VH0
 d7I39GBBKJEbD4aCvL3zL5Uxlwd6b8Azggb9ohSZLIRaV2bLWsXoFj4Wfk5n+DVD4Nqa5x2qLGB
 OUgOwpj2LDiCipLwlOZZvyIsUfsH2w2k+rJbWHC4
X-Received: by 2002:a17:907:d09:b0:b8f:c684:db3f with SMTP id
 a640c23a62f3a-b9356f73ad6mr835386366b.12.1772408198468; Sun, 01 Mar 2026
 15:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20260225142310.51f75f4d@phoenix.local>
 <20260301232931.444294-1-maxime.peim@gmail.com>
In-Reply-To: <20260301232931.444294-1-maxime.peim@gmail.com>
From: Maxime Peim <maxime.peim@gmail.com>
Date: Mon, 2 Mar 2026 00:36:26 +0100
X-Gm-Features: AaiRm53ZJTOQbXz3a2Ve066XhbFjBGcWr0tLtpq8zl6maBIRwJ5wT2xUpVofH64
Message-ID: <CACyZvziKL3Vu9d3GgHj8274dgf6BmzwySdvhEupmwkb+60bF1Q@mail.gmail.com>
Subject: Re: [PATCH v2] test/flow: add support for async API
To: dev@dpdk.org
Cc: stephen@networkplumber.org
Content-Type: multipart/alternative; boundary="0000000000001117a8064bfef186"
X-Mailman-Approved-At: Mon, 02 Mar 2026 09:05:41 +0100
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

--0000000000001117a8064bfef186
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Thanks for the review!
Some of  the AI generated comments were indeed issues, but already there
before my changes (the global flow variable for example).
So I updated my changes to fix those nevertheless.

Let me know if any other changes are needed.
Also, I have made improvement by pre-allocating a memory pool for async
flows:
 - it avoid every in-flight flow in the queue to point to the same items /
actions when using static variables
 - it allows better locality and cache usage
With this change I was able to double the number of flows I can insert on a
BF3.

On Mon, Mar 2, 2026 at 12:29=E2=80=AFAM Maxime Peim <maxime.peim@gmail.com>=
 wrote:

> Add async flow API mode to test-flow-perf application for improved
> flow rule insertion performance. The async API allows batching flow
> rule creation operations and processing completions in bulk, reducing
> per-rule overhead.
>
> New command line options:
>   --async: enable async flow API mode
>   --async-queue-size=3DN: size of async queues (default: 1024)
>   --async-push-batch=3DN: flows to batch before push (default: 256)
>
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> ---
> v2:
>   - Replace per-flow stack allocation with pre-allocated slot pool;
>     flat buffers are initialized once at init time and the hot path
>     only patches per-flow item/action values into a pre-set slot
>   - Fix alloca misuse: use heap allocation for queue_attr_list, round
>     queue_size to power of 2 for bitmask wrapping, add bounds checks
>   - Fix race on file-scope flow variable, premature latency
>     measurement, and integer division in rate calculation
>   - Drop unrelated lgopts reformatting
>   - Use malloc instead of rte_zmalloc for non-dataplane allocations
>   - Various robustness and style fixes
>
>  app/test-flow-perf/actions_gen.c | 281 +++++++++++-
>  app/test-flow-perf/actions_gen.h |  31 ++
>  app/test-flow-perf/async_flow.c  | 761 +++++++++++++++++++++++++++++++
>  app/test-flow-perf/async_flow.h  |  54 +++
>  app/test-flow-perf/items_gen.c   |  58 +++
>  app/test-flow-perf/items_gen.h   |   6 +
>  app/test-flow-perf/main.c        | 302 +++++++++++-
>  app/test-flow-perf/meson.build   |   1 +
>  8 files changed, 1454 insertions(+), 40 deletions(-)
>  create mode 100644 app/test-flow-perf/async_flow.c
>  create mode 100644 app/test-flow-perf/async_flow.h
>
> diff --git a/app/test-flow-perf/actions_gen.c
> b/app/test-flow-perf/actions_gen.c
> index 9d102e3af4..2b8edd50c8 100644
> --- a/app/test-flow-perf/actions_gen.c
> +++ b/app/test-flow-perf/actions_gen.c
> @@ -36,27 +36,7 @@ struct additional_para {
>         bool unique_data;
>  };
>
> -/* Storage for struct rte_flow_action_raw_encap including external data.
> */
> -struct action_raw_encap_data {
> -       struct rte_flow_action_raw_encap conf;
> -       uint8_t data[128];
> -       uint8_t preserve[128];
> -       uint16_t idx;
> -};
> -
> -/* Storage for struct rte_flow_action_raw_decap including external data.
> */
> -struct action_raw_decap_data {
> -       struct rte_flow_action_raw_decap conf;
> -       uint8_t data[128];
> -       uint16_t idx;
> -};
> -
> -/* Storage for struct rte_flow_action_rss including external data. */
> -struct action_rss_data {
> -       struct rte_flow_action_rss conf;
> -       uint8_t key[40];
> -       uint16_t queue[128];
> -};
> +/* Compound action data structs defined in actions_gen.h */
>
>  static void
>  add_mark(struct rte_flow_action *actions,
> @@ -1165,3 +1145,262 @@ fill_actions(struct rte_flow_action *actions,
> uint64_t *flow_actions,
>         free(queues);
>         free(hairpin_queues);
>  }
> +
> +static size_t
> +action_conf_size(enum rte_flow_action_type type)
> +{
> +       switch (type) {
> +       case RTE_FLOW_ACTION_TYPE_MARK:
> +               return sizeof(struct rte_flow_action_mark);
> +       case RTE_FLOW_ACTION_TYPE_QUEUE:
> +               return sizeof(struct rte_flow_action_queue);
> +       case RTE_FLOW_ACTION_TYPE_JUMP:
> +               return sizeof(struct rte_flow_action_jump);
> +       case RTE_FLOW_ACTION_TYPE_RSS:
> +               return sizeof(struct action_rss_data);
> +       case RTE_FLOW_ACTION_TYPE_SET_META:
> +               return sizeof(struct rte_flow_action_set_meta);
> +       case RTE_FLOW_ACTION_TYPE_SET_TAG:
> +               return sizeof(struct rte_flow_action_set_tag);
> +       case RTE_FLOW_ACTION_TYPE_PORT_ID:
> +               return sizeof(struct rte_flow_action_port_id);
> +       case RTE_FLOW_ACTION_TYPE_COUNT:
> +               return sizeof(struct rte_flow_action_count);
> +       case RTE_FLOW_ACTION_TYPE_SET_MAC_SRC:
> +       case RTE_FLOW_ACTION_TYPE_SET_MAC_DST:
> +               return sizeof(struct rte_flow_action_set_mac);
> +       case RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC:
> +       case RTE_FLOW_ACTION_TYPE_SET_IPV4_DST:
> +               return sizeof(struct rte_flow_action_set_ipv4);
> +       case RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC:
> +       case RTE_FLOW_ACTION_TYPE_SET_IPV6_DST:
> +               return sizeof(struct rte_flow_action_set_ipv6);
> +       case RTE_FLOW_ACTION_TYPE_SET_TP_SRC:
> +       case RTE_FLOW_ACTION_TYPE_SET_TP_DST:
> +               return sizeof(struct rte_flow_action_set_tp);
> +       case RTE_FLOW_ACTION_TYPE_INC_TCP_ACK:
> +       case RTE_FLOW_ACTION_TYPE_DEC_TCP_ACK:
> +       case RTE_FLOW_ACTION_TYPE_INC_TCP_SEQ:
> +       case RTE_FLOW_ACTION_TYPE_DEC_TCP_SEQ:
> +               return sizeof(rte_be32_t);
> +       case RTE_FLOW_ACTION_TYPE_SET_TTL:
> +               return sizeof(struct rte_flow_action_set_ttl);
> +       case RTE_FLOW_ACTION_TYPE_SET_IPV4_DSCP:
> +       case RTE_FLOW_ACTION_TYPE_SET_IPV6_DSCP:
> +               return sizeof(struct rte_flow_action_set_dscp);
> +       case RTE_FLOW_ACTION_TYPE_METER:
> +               return sizeof(struct rte_flow_action_meter);
> +       case RTE_FLOW_ACTION_TYPE_RAW_ENCAP:
> +               return sizeof(struct action_raw_encap_data);
> +       case RTE_FLOW_ACTION_TYPE_RAW_DECAP:
> +               return sizeof(struct action_raw_decap_data);
> +       case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP:
> +               return sizeof(struct rte_flow_action_vxlan_encap) +
> +                      5 * sizeof(struct rte_flow_item) + sizeof(struct
> rte_flow_item_eth) +
> +                      sizeof(struct rte_flow_item_ipv4) + sizeof(struct
> rte_flow_item_udp) +
> +                      sizeof(struct rte_flow_item_vxlan);
> +       case RTE_FLOW_ACTION_TYPE_MODIFY_FIELD:
> +               return sizeof(struct rte_flow_action_modify_field);
> +       /* Zero-conf types */
> +       case RTE_FLOW_ACTION_TYPE_DROP:
> +       case RTE_FLOW_ACTION_TYPE_FLAG:
> +       case RTE_FLOW_ACTION_TYPE_DEC_TTL:
> +       case RTE_FLOW_ACTION_TYPE_VXLAN_DECAP:
> +               return 0;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +void
> +fill_actions_template(struct rte_flow_action *actions, struct
> rte_flow_action *masks,
> +                     uint64_t *flow_actions, struct rte_flow_port_attr
> *port_attr,
> +                     bool *need_wire_orig_table, size_t *conf_sizes,
> uint32_t *n_actions_out)
> +{
> +       uint8_t actions_counter =3D 0;
> +       uint8_t i, j;
> +
> +       *need_wire_orig_table =3D false;
> +       memset(port_attr, 0, sizeof(*port_attr));
> +
> +       /* Static configurations for actions that need them in templates =
*/
> +       static struct rte_flow_action_mark mark_conf =3D {
> +               .id =3D 1,
> +       };
> +       static struct rte_flow_action_queue queue_conf =3D {
> +               .index =3D 0,
> +       };
> +       static struct rte_flow_action_port_id port_id_conf =3D {
> +               .id =3D 0,
> +       };
> +       static struct rte_flow_action_jump jump_conf =3D {
> +               .group =3D 1,
> +       };
> +       static struct rte_flow_action_modify_field set_meta_conf =3D {
> +               .operation =3D RTE_FLOW_MODIFY_SET,
> +               .dst =3D {.field =3D RTE_FLOW_FIELD_META},
> +               .src =3D
> +                       {
> +                               .field =3D RTE_FLOW_FIELD_VALUE,
> +                               .value =3D {0, 0, 0, META_DATA},
> +                       },
> +               .width =3D 32,
> +       };
> +
> +       /* Static mask configurations for each action type */
> +       static struct rte_flow_action_mark mark_mask =3D {
> +               .id =3D UINT32_MAX,
> +       };
> +       static struct rte_flow_action_queue queue_mask =3D {
> +               .index =3D UINT16_MAX,
> +       };
> +       static struct rte_flow_action_jump jump_mask =3D {
> +               .group =3D UINT32_MAX,
> +       };
> +       static struct rte_flow_action_rss rss_mask =3D {
> +               .level =3D UINT32_MAX,
> +               .types =3D UINT64_MAX,
> +       };
> +       static struct rte_flow_action_set_meta set_meta_mask =3D {
> +               .data =3D UINT32_MAX,
> +               .mask =3D UINT32_MAX,
> +       };
> +       static struct rte_flow_action_set_tag set_tag_mask =3D {
> +               .data =3D UINT32_MAX,
> +               .mask =3D UINT32_MAX,
> +               .index =3D UINT8_MAX,
> +       };
> +       static struct rte_flow_action_port_id port_id_mask =3D {
> +               .id =3D UINT32_MAX,
> +       };
> +       static struct rte_flow_action_count count_mask;
> +       static struct rte_flow_action_set_mac set_mac_mask =3D {
> +               .mac_addr =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
> +       };
> +       static struct rte_flow_action_set_ipv4 set_ipv4_mask =3D {
> +               .ipv4_addr =3D UINT32_MAX,
> +       };
> +       static struct rte_flow_action_set_ipv6 set_ipv6_mask =3D {
> +               .ipv6_addr.a =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xf=
f,
> 0xff, 0xff, 0xff, 0xff,
> +                               0xff, 0xff, 0xff, 0xff, 0xff}};
> +       static struct rte_flow_action_set_tp set_tp_mask =3D {
> +               .port =3D UINT16_MAX,
> +       };
> +       static rte_be32_t tcp_seq_ack_mask =3D UINT32_MAX;
> +       static struct rte_flow_action_set_ttl set_ttl_mask =3D {
> +               .ttl_value =3D UINT8_MAX,
> +       };
> +       static struct rte_flow_action_set_dscp set_dscp_mask =3D {
> +               .dscp =3D UINT8_MAX,
> +       };
> +       static struct rte_flow_action_meter meter_mask =3D {
> +               .mtr_id =3D UINT32_MAX,
> +       };
> +
> +       static const struct {
> +               uint64_t flow_mask;
> +               enum rte_flow_action_type type;
> +               const void *action_conf;
> +               const void *action_mask;
> +               const bool need_wire_orig_table;
> +       } template_actions[] =3D {
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_MARK),
> RTE_FLOW_ACTION_TYPE_MARK, &mark_conf,
> +                &mark_mask, true},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_COUNT),
> RTE_FLOW_ACTION_TYPE_COUNT, NULL,
> +                &count_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_MODIFY_FIELD),
> +                RTE_FLOW_ACTION_TYPE_MODIFY_FIELD, &set_meta_conf,
> &set_meta_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_TAG),
> RTE_FLOW_ACTION_TYPE_SET_TAG, NULL,
> +                &set_tag_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_FLAG),
> RTE_FLOW_ACTION_TYPE_FLAG, NULL, NULL,
> +                false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_MAC_SRC),
> +                RTE_FLOW_ACTION_TYPE_SET_MAC_SRC, NULL, &set_mac_mask,
> false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_MAC_DST),
> +                RTE_FLOW_ACTION_TYPE_SET_MAC_DST, NULL, &set_mac_mask,
> false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC),
> +                RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC, NULL, &set_ipv4_mask,
> false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV4_DST),
> +                RTE_FLOW_ACTION_TYPE_SET_IPV4_DST, NULL, &set_ipv4_mask,
> false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC),
> +                RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC, NULL, &set_ipv6_mask,
> false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV6_DST),
> +                RTE_FLOW_ACTION_TYPE_SET_IPV6_DST, NULL, &set_ipv6_mask,
> false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_TP_SRC),
> RTE_FLOW_ACTION_TYPE_SET_TP_SRC,
> +                NULL, &set_tp_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_TP_DST),
> RTE_FLOW_ACTION_TYPE_SET_TP_DST,
> +                NULL, &set_tp_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_INC_TCP_ACK),
> +                RTE_FLOW_ACTION_TYPE_INC_TCP_ACK, NULL,
> &tcp_seq_ack_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DEC_TCP_ACK),
> +                RTE_FLOW_ACTION_TYPE_DEC_TCP_ACK, NULL,
> &tcp_seq_ack_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_INC_TCP_SEQ),
> +                RTE_FLOW_ACTION_TYPE_INC_TCP_SEQ, NULL,
> &tcp_seq_ack_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DEC_TCP_SEQ),
> +                RTE_FLOW_ACTION_TYPE_DEC_TCP_SEQ, NULL,
> &tcp_seq_ack_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_TTL),
> RTE_FLOW_ACTION_TYPE_SET_TTL, NULL,
> +                &set_ttl_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DEC_TTL),
> RTE_FLOW_ACTION_TYPE_DEC_TTL, NULL,
> +                NULL, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV4_DSCP),
> +                RTE_FLOW_ACTION_TYPE_SET_IPV4_DSCP, NULL, &set_dscp_mask=
,
> false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV6_DSCP),
> +                RTE_FLOW_ACTION_TYPE_SET_IPV6_DSCP, NULL, &set_dscp_mask=
,
> false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_QUEUE),
> RTE_FLOW_ACTION_TYPE_QUEUE,
> +                &queue_conf, &queue_mask, true},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_RSS),
> RTE_FLOW_ACTION_TYPE_RSS, NULL,
> +                &rss_mask, true},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_JUMP),
> RTE_FLOW_ACTION_TYPE_JUMP, &jump_conf,
> +                &jump_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_PORT_ID),
> RTE_FLOW_ACTION_TYPE_PORT_ID,
> +                &port_id_conf, &port_id_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DROP),
> RTE_FLOW_ACTION_TYPE_DROP, NULL, NULL,
> +                false},
> +               {HAIRPIN_QUEUE_ACTION, RTE_FLOW_ACTION_TYPE_QUEUE,
> &queue_conf, &queue_mask, false},
> +               {HAIRPIN_RSS_ACTION, RTE_FLOW_ACTION_TYPE_RSS, NULL,
> &rss_mask, false},
> +               {FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_METER),
> RTE_FLOW_ACTION_TYPE_METER, NULL,
> +                &meter_mask, false},
> +       };
> +
> +       for (j =3D 0; j < MAX_ACTIONS_NUM; j++) {
> +               if (flow_actions[j] =3D=3D 0)
> +                       break;
> +               for (i =3D 0; i < RTE_DIM(template_actions); i++) {
> +                       if ((flow_actions[j] &
> template_actions[i].flow_mask) =3D=3D 0)
> +                               continue;
> +
> +                       switch (template_actions[i].type) {
> +                       case RTE_FLOW_ACTION_TYPE_COUNT:
> +                               port_attr->nb_counters++;
> +                               break;
> +                       case RTE_FLOW_ACTION_TYPE_AGE:
> +                               port_attr->nb_aging_objects++;
> +                               break;
> +                       case RTE_FLOW_ACTION_TYPE_METER:
> +                               port_attr->nb_meters++;
> +                               break;
> +                       case RTE_FLOW_ACTION_TYPE_CONNTRACK:
> +                               port_attr->nb_conn_tracks++;
> +                               break;
> +                       case RTE_FLOW_ACTION_TYPE_QUOTA:
> +                               port_attr->nb_quotas++;
> +                       default:;
> +                       }
> +
> +                       actions[actions_counter].type =3D
> template_actions[i].type;
> +                       actions[actions_counter].conf =3D
> template_actions[i].action_conf;
> +                       masks[actions_counter].type =3D
> template_actions[i].type;
> +                       masks[actions_counter].conf =3D
> template_actions[i].action_mask;
> +                       conf_sizes[actions_counter] =3D
> action_conf_size(template_actions[i].type);
> +                       *need_wire_orig_table |=3D
> template_actions[i].need_wire_orig_table;
> +                       actions_counter++;
> +                       break;
> +               }
> +       }
> +
> +       actions[actions_counter].type =3D RTE_FLOW_ACTION_TYPE_END;
> +       masks[actions_counter].type =3D RTE_FLOW_ACTION_TYPE_END;
> +
> +       /* take END into account */
> +       *n_actions_out =3D actions_counter + 1;
> +}
> diff --git a/app/test-flow-perf/actions_gen.h
> b/app/test-flow-perf/actions_gen.h
> index 9e13b164f9..3ac0ffed59 100644
> --- a/app/test-flow-perf/actions_gen.h
> +++ b/app/test-flow-perf/actions_gen.h
> @@ -17,9 +17,40 @@
>  #define RTE_VXLAN_GPE_UDP_PORT 250
>  #define RTE_GENEVE_UDP_PORT 6081
>
> +/* Compound action data structures (needed by async_flow.c for slot init=
)
> */
> +
> +/* Storage for struct rte_flow_action_raw_encap including external data.
> */
> +struct action_raw_encap_data {
> +       struct rte_flow_action_raw_encap conf;
> +       uint8_t data[128];
> +       uint8_t preserve[128];
> +       uint16_t idx;
> +};
> +
> +/* Storage for struct rte_flow_action_raw_decap including external data.
> */
> +struct action_raw_decap_data {
> +       struct rte_flow_action_raw_decap conf;
> +       uint8_t data[128];
> +       uint16_t idx;
> +};
> +
> +/* Storage for struct rte_flow_action_rss including external data. */
> +struct action_rss_data {
> +       struct rte_flow_action_rss conf;
> +       uint8_t key[40];
> +       uint16_t queue[128];
> +};
> +
>  void fill_actions(struct rte_flow_action *actions, uint64_t *flow_action=
s,
>         uint32_t counter, uint16_t next_table, uint16_t hairpinq,
>         uint64_t encap_data, uint64_t decap_data, uint8_t core_idx,
>         bool unique_data, uint8_t rx_queues_count, uint16_t dst_port);
>
> +/* Fill actions template for async flow API (types only, no values).
> + * If conf_sizes is non-NULL, populates per-action conf sizes and
> n_actions_out.
> + */
> +void fill_actions_template(struct rte_flow_action *actions, struct
> rte_flow_action *masks,
> +                          uint64_t *flow_actions, struct
> rte_flow_port_attr *port_attr,
> +                          bool *need_wire_orig_table, size_t *conf_sizes=
,
> uint32_t *n_actions_out);
> +
>  #endif /* FLOW_PERF_ACTION_GEN */
> diff --git a/app/test-flow-perf/async_flow.c
> b/app/test-flow-perf/async_flow.c
> new file mode 100644
> index 0000000000..ae5a922856
> --- /dev/null
> +++ b/app/test-flow-perf/async_flow.c
> @@ -0,0 +1,761 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright 2026 Maxime Peim <maxime.peim@gmail.com>
> + *
> + * This file contains the async flow API implementation
> + * for the flow-perf application.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <rte_bitops.h>
> +#include <rte_common.h>
> +#include <rte_ethdev.h>
> +#include <rte_flow.h>
> +#include <rte_vxlan.h>
> +
> +#include "actions_gen.h"
> +#include "async_flow.h"
> +#include "flow_gen.h"
> +#include "items_gen.h"
> +
> +/* Max iterations when draining pending async completions during cleanup
> */
> +#define DRAIN_MAX_ITERATIONS 100
> +
> +/* Per-port async flow resources */
> +static struct async_flow_resources port_resources[MAX_PORTS];
> +
> +/*
> + * Initialize compound action types within a pre-allocated slot.
> + * Called once per slot during pool init to set up internal pointers
> + * for RSS, RAW_ENCAP, RAW_DECAP and VXLAN_ENCAP actions.
> + */
> +static void
> +init_slot_compound_actions(struct rte_flow_action *actions, uint32_t
> n_actions,
> +                          const size_t *action_conf_sizes)
> +{
> +       uint32_t i;
> +
> +       for (i =3D 0; i < n_actions; i++) {
> +               if (action_conf_sizes[i] =3D=3D 0)
> +                       continue;
> +
> +               switch (actions[i].type) {
> +               case RTE_FLOW_ACTION_TYPE_RSS: {
> +                       struct action_rss_data *rss =3D
> +                               (struct action_rss_data
> *)(uintptr_t)actions[i].conf;
> +                       rss->conf.func =3D RTE_ETH_HASH_FUNCTION_DEFAULT;
> +                       rss->conf.level =3D 0;
> +                       rss->conf.types =3D GET_RSS_HF();
> +                       rss->conf.key_len =3D sizeof(rss->key);
> +                       rss->conf.key =3D rss->key;
> +                       rss->conf.queue =3D rss->queue;
> +                       rss->key[0] =3D 1;
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_RAW_ENCAP: {
> +                       struct action_raw_encap_data *encap =3D
> +                               (struct action_raw_encap_data
> *)(uintptr_t)actions[i].conf;
> +                       encap->conf.data =3D encap->data;
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_RAW_DECAP: {
> +                       struct action_raw_decap_data *decap =3D
> +                               (struct action_raw_decap_data
> *)(uintptr_t)actions[i].conf;
> +                       decap->conf.data =3D decap->data;
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP: {
> +                       /*
> +                        * Layout within the conf area:
> +                        *   struct rte_flow_action_vxlan_encap
> +                        *   struct rte_flow_item[5]
> +                        *   struct rte_flow_item_eth
> +                        *   struct rte_flow_item_ipv4
> +                        *   struct rte_flow_item_udp
> +                        *   struct rte_flow_item_vxlan
> +                        */
> +                       uint8_t *base =3D (uint8_t
> *)(uintptr_t)actions[i].conf;
> +                       struct rte_flow_action_vxlan_encap *ve =3D
> +                               (struct rte_flow_action_vxlan_encap *)bas=
e;
> +                       struct rte_flow_item *items =3D
> +                               (struct rte_flow_item
> +                                        *)(base + sizeof(struct
> rte_flow_action_vxlan_encap));
> +                       uint8_t *data =3D (uint8_t *)(items + 5);
> +
> +                       struct rte_flow_item_eth *item_eth =3D (struct
> rte_flow_item_eth *)data;
> +                       data +=3D sizeof(struct rte_flow_item_eth);
> +                       struct rte_flow_item_ipv4 *item_ipv4 =3D (struct
> rte_flow_item_ipv4 *)data;
> +                       data +=3D sizeof(struct rte_flow_item_ipv4);
> +                       struct rte_flow_item_udp *item_udp =3D (struct
> rte_flow_item_udp *)data;
> +                       data +=3D sizeof(struct rte_flow_item_udp);
> +                       struct rte_flow_item_vxlan *item_vxlan =3D (struc=
t
> rte_flow_item_vxlan *)data;
> +
> +                       memset(item_eth, 0, sizeof(*item_eth));
> +                       memset(item_ipv4, 0, sizeof(*item_ipv4));
> +                       memset(item_udp, 0, sizeof(*item_udp));
> +                       memset(item_vxlan, 0, sizeof(*item_vxlan));
> +
> +                       item_ipv4->hdr.src_addr =3D RTE_IPV4(127, 0, 0, 1=
);
> +                       item_ipv4->hdr.version_ihl =3D RTE_IPV4_VHL_DEF;
> +                       item_udp->hdr.dst_port =3D
> RTE_BE16(RTE_VXLAN_DEFAULT_PORT);
> +                       item_vxlan->hdr.vni[2] =3D 1;
> +
> +                       items[0].type =3D RTE_FLOW_ITEM_TYPE_ETH;
> +                       items[0].spec =3D item_eth;
> +                       items[0].mask =3D item_eth;
> +                       items[1].type =3D RTE_FLOW_ITEM_TYPE_IPV4;
> +                       items[1].spec =3D item_ipv4;
> +                       items[1].mask =3D item_ipv4;
> +                       items[2].type =3D RTE_FLOW_ITEM_TYPE_UDP;
> +                       items[2].spec =3D item_udp;
> +                       items[2].mask =3D item_udp;
> +                       items[3].type =3D RTE_FLOW_ITEM_TYPE_VXLAN;
> +                       items[3].spec =3D item_vxlan;
> +                       items[3].mask =3D item_vxlan;
> +                       items[4].type =3D RTE_FLOW_ITEM_TYPE_END;
> +
> +                       ve->definition =3D items;
> +                       break;
> +               }
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +/*
> + * Allocate and pre-initialize all per-slot flat buffers.
> + * Returns 0 on success.
> + */
> +static int
> +init_slot_pool(struct async_flow_resources *res, uint32_t nb_queues,
> uint32_t queue_size,
> +              const struct rte_flow_item *pattern, uint32_t n_items,
> const size_t *item_spec_sizes,
> +              const struct rte_flow_action *template_actions, uint32_t
> n_actions,
> +              const size_t *action_conf_sizes)
> +{
> +       uint32_t items_array_bytes, actions_array_bytes;
> +       uint32_t spec_data_bytes, conf_data_bytes, mask_data_bytes;
> +       uint32_t slot_size, num_slots;
> +       uint32_t s, i;
> +       uint8_t *mptr;
> +
> +       /* Compute shared mask size */
> +       mask_data_bytes =3D 0;
> +       for (i =3D 0; i < n_items; i++)
> +               mask_data_bytes +=3D RTE_ALIGN_CEIL(item_spec_sizes[i], 8=
);
> +
> +       /* specs and masks have the same size */
> +       spec_data_bytes =3D mask_data_bytes;
> +
> +       conf_data_bytes =3D 0;
> +       for (i =3D 0; i < n_actions; i++)
> +               conf_data_bytes +=3D RTE_ALIGN_CEIL(action_conf_sizes[i],=
 8);
> +
> +       /* Compute per-slot layout sizes (+ 1 for END sentinel) */
> +       items_array_bytes =3D n_items * sizeof(struct rte_flow_item);
> +       actions_array_bytes =3D n_actions * sizeof(struct rte_flow_action=
);
> +
> +       slot_size =3D RTE_ALIGN_CEIL(items_array_bytes + actions_array_by=
tes
> + spec_data_bytes +
> +                                          conf_data_bytes,
> +                                  RTE_CACHE_LINE_SIZE);
> +
> +       num_slots =3D queue_size * nb_queues;
> +
> +       /* Store layout info */
> +       res->slot_size =3D slot_size;
> +       res->slots_per_queue =3D queue_size;
> +       res->nb_queues =3D nb_queues;
> +       res->n_items =3D n_items;
> +       res->n_actions =3D n_actions;
> +
> +       /* Allocate shared masks */
> +       if (mask_data_bytes > 0) {
> +               res->shared_masks =3D aligned_alloc(
> +                       RTE_CACHE_LINE_SIZE,
> RTE_ALIGN_CEIL(mask_data_bytes, RTE_CACHE_LINE_SIZE));
> +               if (res->shared_masks =3D=3D NULL) {
> +                       fprintf(stderr, "Failed to allocate shared masks
> (%u bytes)\n",
> +                               mask_data_bytes);
> +                       return -ENOMEM;
> +               }
> +               memset(res->shared_masks, 0, mask_data_bytes);
> +
> +               /* Copy mask data from template pattern */
> +               mptr =3D res->shared_masks;
> +               for (i =3D 0; i < n_items; i++) {
> +                       if (item_spec_sizes[i] > 0 && pattern[i].mask !=
=3D
> NULL)
> +                               memcpy(mptr, pattern[i].mask,
> item_spec_sizes[i]);
> +                       mptr +=3D RTE_ALIGN_CEIL(item_spec_sizes[i], 8);
> +               }
> +       }
> +
> +       /* Allocate per-slot pool */
> +       /* slot_size is already cache-line aligned, so total is a multipl=
e
> */
> +       res->slot_pool =3D aligned_alloc(RTE_CACHE_LINE_SIZE,
> (size_t)num_slots * slot_size);
> +       if (res->slot_pool =3D=3D NULL) {
> +               fprintf(stderr, "Failed to allocate slot pool (%u slots *
> %u bytes)\n", num_slots,
> +                       slot_size);
> +               free(res->shared_masks);
> +               res->shared_masks =3D NULL;
> +               return -ENOMEM;
> +       }
> +       memset(res->slot_pool, 0, (size_t)num_slots * slot_size);
> +
> +       /* Pre-initialize every slot */
> +       for (s =3D 0; s < num_slots; s++) {
> +               uint8_t *slot =3D res->slot_pool + (size_t)s * slot_size;
> +               struct rte_flow_item *items =3D (struct rte_flow_item *)s=
lot;
> +               struct rte_flow_action *actions =3D
> +                       (struct rte_flow_action *)(slot +
> items_array_bytes);
> +               uint8_t *data =3D slot + items_array_bytes +
> actions_array_bytes;
> +
> +               /* Pre-set items: spec =E2=86=92 per-slot data, mask =E2=
=86=92 shared
> masks */
> +               mptr =3D res->shared_masks;
> +               for (i =3D 0; i < n_items; i++) {
> +                       items[i].type =3D pattern[i].type;
> +                       if (item_spec_sizes[i] > 0) {
> +                               items[i].spec =3D data;
> +                               items[i].mask =3D mptr;
> +                               data +=3D RTE_ALIGN_CEIL(item_spec_sizes[=
i],
> 8);
> +                               mptr +=3D RTE_ALIGN_CEIL(item_spec_sizes[=
i],
> 8);
> +                       }
> +               }
> +               items[n_items].type =3D RTE_FLOW_ITEM_TYPE_END;
> +
> +               /* Pre-set actions: conf =E2=86=92 per-slot data */
> +               for (i =3D 0; i < n_actions; i++) {
> +                       actions[i].type =3D template_actions[i].type;
> +                       if (action_conf_sizes[i] > 0) {
> +                               actions[i].conf =3D data;
> +                               data +=3D
> RTE_ALIGN_CEIL(action_conf_sizes[i], 8);
> +                       }
> +               }
> +               actions[n_actions].type =3D RTE_FLOW_ACTION_TYPE_END;
> +
> +               /* Initialize compound action types (RSS, RAW_ENCAP, etc.=
)
> */
> +               init_slot_compound_actions(actions, n_actions,
> action_conf_sizes);
> +       }
> +
> +       /* Allocate and initialize per-queue slot tracking */
> +       res->queues =3D aligned_alloc(
> +               RTE_CACHE_LINE_SIZE,
> +               RTE_ALIGN_CEIL(nb_queues * sizeof(struct
> async_flow_queue), RTE_CACHE_LINE_SIZE));
> +       if (res->queues =3D=3D NULL) {
> +               fprintf(stderr, "Failed to allocate queue structs (%u
> queues)\n", nb_queues);
> +               free(res->slot_pool);
> +               res->slot_pool =3D NULL;
> +               free(res->shared_masks);
> +               res->shared_masks =3D NULL;
> +               return -ENOMEM;
> +       }
> +       memset(res->queues, 0, nb_queues * sizeof(struct
> async_flow_queue));
> +       for (s =3D 0; s < nb_queues; s++) {
> +               res->queues[s].slots =3D res->slot_pool + (size_t)s *
> queue_size * slot_size;
> +               res->queues[s].head =3D 0;
> +       }
> +
> +       printf(":: Slot pool: %u slots * %u bytes =3D %u KB (shared masks=
:
> %u bytes)\n", num_slots,
> +              slot_size, (num_slots * slot_size) / 1024, mask_data_bytes=
);
> +
> +       return 0;
> +}
> +
> +/*
> + * Hot-path: update per-flow item values through pre-set pointers.
> + * Only IPV4/IPV6 src_addr varies per flow (based on counter).
> + */
> +static void
> +update_item_values(struct rte_flow_item *items, uint32_t counter)
> +{
> +       uint8_t i;
> +
> +       for (i =3D 0; items[i].type !=3D RTE_FLOW_ITEM_TYPE_END; i++) {
> +               switch (items[i].type) {
> +               case RTE_FLOW_ITEM_TYPE_IPV4:
> +                       ((struct rte_flow_item_ipv4
> *)(uintptr_t)items[i].spec)->hdr.src_addr =3D
> +                               RTE_BE32(counter);
> +                       break;
> +               case RTE_FLOW_ITEM_TYPE_IPV6: {
> +                       struct rte_flow_item_ipv6 *spec =3D
> +                               (struct rte_flow_item_ipv6
> *)(uintptr_t)items[i].spec;
> +                       uint8_t j;
> +                       for (j =3D 0; j < 4; j++)
> +                               spec->hdr.src_addr.a[15 - j] =3D counter =
>>
> (j * 8);
> +                       break;
> +               }
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +/*
> + * Hot-path: update per-flow action values through pre-set pointers.
> + */
> +static void
> +update_action_values(struct rte_flow_action *actions, uint32_t counter,
> uint16_t hairpinq,
> +                    uint64_t encap_data, uint64_t decap_data,
> __rte_unused uint8_t core_idx,
> +                    bool unique_data, uint8_t rx_queues_count, uint16_t
> dst_port)
> +{
> +       uint8_t i;
> +
> +       for (i =3D 0; actions[i].type !=3D RTE_FLOW_ACTION_TYPE_END; i++)=
 {
> +               switch (actions[i].type) {
> +               case RTE_FLOW_ACTION_TYPE_MARK:
> +                       ((struct rte_flow_action_mark
> *)(uintptr_t)actions[i].conf)->id =3D
> +                               (counter % 255) + 1;
> +                       break;
> +               case RTE_FLOW_ACTION_TYPE_QUEUE:
> +                       ((struct rte_flow_action_queue
> *)(uintptr_t)actions[i].conf)->index =3D
> +                               hairpinq ? (counter % hairpinq) +
> rx_queues_count :
> +                                          counter % rx_queues_count;
> +                       break;
> +               case RTE_FLOW_ACTION_TYPE_METER:
> +                       ((struct rte_flow_action_meter
> *)(uintptr_t)actions[i].conf)->mtr_id =3D
> +                               counter;
> +                       break;
> +               case RTE_FLOW_ACTION_TYPE_RSS: {
> +                       struct action_rss_data *rss =3D
> +                               (struct action_rss_data
> *)(uintptr_t)actions[i].conf;
> +                       uint16_t q;
> +                       if (hairpinq) {
> +                               rss->conf.queue_num =3D hairpinq;
> +                               for (q =3D 0; q < hairpinq; q++)
> +                                       rss->queue[q] =3D q +
> rx_queues_count;
> +                       } else {
> +                               rss->conf.queue_num =3D rx_queues_count;
> +                               for (q =3D 0; q < rx_queues_count; q++)
> +                                       rss->queue[q] =3D q;
> +                       }
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_SET_MAC_SRC:
> +               case RTE_FLOW_ACTION_TYPE_SET_MAC_DST: {
> +                       struct rte_flow_action_set_mac *mac =3D
> +                               (struct rte_flow_action_set_mac
> *)(uintptr_t)actions[i].conf;
> +                       uint32_t val =3D unique_data ? counter : 1;
> +                       uint8_t j;
> +                       for (j =3D 0; j < RTE_ETHER_ADDR_LEN; j++) {
> +                               mac->mac_addr[j] =3D val & 0xff;
> +                               val >>=3D 8;
> +                       }
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC:
> +               case RTE_FLOW_ACTION_TYPE_SET_IPV4_DST: {
> +                       uint32_t ip =3D unique_data ? counter : 1;
> +                       ((struct rte_flow_action_set_ipv4
> *)(uintptr_t)actions[i].conf)->ipv4_addr =3D
> +                               RTE_BE32(ip + 1);
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC:
> +               case RTE_FLOW_ACTION_TYPE_SET_IPV6_DST: {
> +                       struct rte_flow_action_set_ipv6 *v6 =3D
> +                               (struct rte_flow_action_set_ipv6
> *)(uintptr_t)actions[i].conf;
> +                       uint32_t val =3D unique_data ? counter : 1;
> +                       uint8_t j;
> +                       for (j =3D 0; j < 16; j++) {
> +                               v6->ipv6_addr.a[j] =3D val & 0xff;
> +                               val >>=3D 8;
> +                       }
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_SET_TP_SRC: {
> +                       uint32_t tp =3D unique_data ? counter : 100;
> +                       tp =3D tp % 0xffff;
> +                       ((struct rte_flow_action_set_tp
> *)(uintptr_t)actions[i].conf)->port =3D
> +                               RTE_BE16(tp & 0xffff);
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_SET_TP_DST: {
> +                       uint32_t tp =3D unique_data ? counter : 100;
> +                       if (tp > 0xffff)
> +                               tp >>=3D 16;
> +                       ((struct rte_flow_action_set_tp
> *)(uintptr_t)actions[i].conf)->port =3D
> +                               RTE_BE16(tp & 0xffff);
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_INC_TCP_ACK:
> +               case RTE_FLOW_ACTION_TYPE_DEC_TCP_ACK:
> +               case RTE_FLOW_ACTION_TYPE_INC_TCP_SEQ:
> +               case RTE_FLOW_ACTION_TYPE_DEC_TCP_SEQ: {
> +                       uint32_t val =3D unique_data ? counter : 1;
> +                       *(rte_be32_t *)(uintptr_t)actions[i].conf =3D
> RTE_BE32(val);
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_SET_TTL: {
> +                       uint32_t val =3D unique_data ? counter : 1;
> +                       ((struct rte_flow_action_set_ttl
> *)(uintptr_t)actions[i].conf)->ttl_value =3D
> +                               val % 0xff;
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_SET_IPV4_DSCP:
> +               case RTE_FLOW_ACTION_TYPE_SET_IPV6_DSCP: {
> +                       uint32_t val =3D unique_data ? counter : 1;
> +                       ((struct rte_flow_action_set_dscp
> *)(uintptr_t)actions[i].conf)->dscp =3D
> +                               val % 0xff;
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_PORT_ID:
> +                       ((struct rte_flow_action_port_id
> *)(uintptr_t)actions[i].conf)->id =3D
> +                               dst_port;
> +                       break;
> +               case RTE_FLOW_ACTION_TYPE_RAW_ENCAP: {
> +                       struct action_raw_encap_data *encap =3D
> +                               (struct action_raw_encap_data
> *)(uintptr_t)actions[i].conf;
> +                       uint8_t *header =3D encap->data;
> +                       struct rte_ether_hdr eth_hdr;
> +                       struct rte_ipv4_hdr ipv4_hdr;
> +                       struct rte_udp_hdr udp_hdr;
> +
> +                       memset(&eth_hdr, 0, sizeof(eth_hdr));
> +                       if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_ETH)) {
> +                               if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_VLAN))
> +                                       eth_hdr.ether_type =3D
> RTE_BE16(RTE_ETHER_TYPE_VLAN);
> +                               else if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV4))
> +                                       eth_hdr.ether_type =3D
> RTE_BE16(RTE_ETHER_TYPE_IPV4);
> +                               else if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV6))
> +                                       eth_hdr.ether_type =3D
> RTE_BE16(RTE_ETHER_TYPE_IPV6);
> +                               memcpy(header, &eth_hdr, sizeof(eth_hdr))=
;
> +                               header +=3D sizeof(eth_hdr);
> +                       }
> +                       if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV4)) {
> +                               uint32_t ip_dst =3D unique_data ? counter=
 :
> 1;
> +                               memset(&ipv4_hdr, 0, sizeof(ipv4_hdr));
> +                               ipv4_hdr.src_addr =3D RTE_IPV4(127, 0, 0,=
 1);
> +                               ipv4_hdr.dst_addr =3D RTE_BE32(ip_dst);
> +                               ipv4_hdr.version_ihl =3D RTE_IPV4_VHL_DEF=
;
> +                               if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_UDP))
> +                                       ipv4_hdr.next_proto_id =3D 17; /*
> UDP */
> +                               if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_GRE))
> +                                       ipv4_hdr.next_proto_id =3D 47; /*
> GRE */
> +                               memcpy(header, &ipv4_hdr,
> sizeof(ipv4_hdr));
> +                               header +=3D sizeof(ipv4_hdr);
> +                       }
> +                       if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_UDP)) {
> +                               memset(&udp_hdr, 0, sizeof(udp_hdr));
> +                               if (encap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_VXLAN))
> +                                       udp_hdr.dst_port =3D
> RTE_BE16(RTE_VXLAN_DEFAULT_PORT);
> +                               memcpy(header, &udp_hdr, sizeof(udp_hdr))=
;
> +                               header +=3D sizeof(udp_hdr);
> +                       }
> +                       encap->conf.size =3D header - encap->data;
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_RAW_DECAP: {
> +                       struct action_raw_decap_data *decap_d =3D
> +                               (struct action_raw_decap_data
> *)(uintptr_t)actions[i].conf;
> +                       uint8_t *header =3D decap_d->data;
> +                       struct rte_ether_hdr eth_hdr;
> +
> +                       memset(&eth_hdr, 0, sizeof(eth_hdr));
> +                       if (decap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_ETH)) {
> +                               if (decap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV4))
> +                                       eth_hdr.ether_type =3D
> RTE_BE16(RTE_ETHER_TYPE_IPV4);
> +                               else if (decap_data &
> FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV6))
> +                                       eth_hdr.ether_type =3D
> RTE_BE16(RTE_ETHER_TYPE_IPV6);
> +                               memcpy(header, &eth_hdr, sizeof(eth_hdr))=
;
> +                               header +=3D sizeof(eth_hdr);
> +                       }
> +                       decap_d->conf.size =3D header - decap_d->data;
> +                       break;
> +               }
> +               case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP: {
> +                       uint8_t *base =3D (uint8_t
> *)(uintptr_t)actions[i].conf;
> +                       struct rte_flow_item *vitems =3D
> +                               (struct rte_flow_item
> +                                        *)(base + sizeof(struct
> rte_flow_action_vxlan_encap));
> +                       uint32_t ip_dst =3D unique_data ? counter : 1;
> +                       /* vitems[1] is IPV4 */
> +                       ((struct rte_flow_item_ipv4
> *)(uintptr_t)vitems[1].spec)->hdr.dst_addr =3D
> +                               RTE_BE32(ip_dst);
> +                       break;
> +               }
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +int
> +async_flow_init_port(uint16_t port_id, uint32_t nb_queues, uint32_t
> queue_size,
> +                    uint64_t *flow_items, uint64_t *flow_actions,
> uint64_t *flow_attrs,
> +                    uint8_t flow_group, uint32_t rules_count)
> +{
> +       struct rte_flow_port_info port_info =3D {0};
> +       struct rte_flow_queue_info queue_info =3D {0};
> +       struct rte_flow_error error =3D {0};
> +       struct rte_flow_port_attr port_attr =3D {0};
> +       struct rte_flow_queue_attr queue_attr;
> +       const struct rte_flow_queue_attr **queue_attr_list;
> +       struct rte_flow_pattern_template_attr pt_attr =3D {0};
> +       struct rte_flow_actions_template_attr at_attr =3D {0};
> +       struct rte_flow_template_table_attr table_attr =3D {0};
> +       struct rte_flow_item pattern[MAX_ITEMS_NUM];
> +       struct rte_flow_action actions[MAX_ACTIONS_NUM];
> +       struct rte_flow_action action_masks[MAX_ACTIONS_NUM];
> +       size_t item_spec_sizes[MAX_ITEMS_NUM];
> +       size_t action_conf_sizes[MAX_ACTIONS_NUM];
> +       uint32_t n_items, n_actions;
> +       struct async_flow_resources *res;
> +       bool need_wire_orig_table =3D false;
> +       uint32_t i;
> +       int ret;
> +
> +       if (port_id >=3D MAX_PORTS)
> +               return -1;
> +
> +       res =3D &port_resources[port_id];
> +       memset(res, 0, sizeof(*res));
> +
> +       /* Query port flow info */
> +       ret =3D rte_flow_info_get(port_id, &port_info, &queue_info, &erro=
r);
> +       if (ret !=3D 0) {
> +               fprintf(stderr, "Port %u: rte_flow_info_get failed: %s\n"=
,
> port_id,
> +                       error.message ? error.message : "(no message)");
> +               return ret;
> +       }
> +
> +       if (port_info.max_nb_queues =3D=3D 0 || queue_info.max_size =3D=
=3D 0) {
> +               fprintf(stderr, "Port %u: rte_flow_info_get reports that
> no queues are supported\n",
> +                       port_id);
> +               return -1;
> +       }
> +
> +       /* Limit to device capabilities if reported */
> +       if (port_info.max_nb_queues !=3D 0 && port_info.max_nb_queues !=
=3D
> UINT32_MAX &&
> +           nb_queues > port_info.max_nb_queues)
> +               nb_queues =3D port_info.max_nb_queues;
> +       if (queue_info.max_size !=3D 0 && queue_info.max_size !=3D UINT32=
_MAX
> &&
> +           queue_size > queue_info.max_size)
> +               queue_size =3D queue_info.max_size;
> +
> +       /* Slot ring uses bitmask wrapping, so queue_size must be power o=
f
> 2 */
> +       queue_size =3D rte_align32prevpow2(queue_size);
> +       if (queue_size =3D=3D 0) {
> +               fprintf(stderr, "Port %u: queue_size is 0 after
> rounding\n", port_id);
> +               return -EINVAL;
> +       }
> +
> +       for (i =3D 0; i < MAX_ATTRS_NUM; i++) {
> +               if (flow_attrs[i] =3D=3D 0)
> +                       break;
> +               if (flow_attrs[i] & INGRESS)
> +                       pt_attr.ingress =3D 1;
> +               else if (flow_attrs[i] & EGRESS)
> +                       pt_attr.egress =3D 1;
> +               else if (flow_attrs[i] & TRANSFER)
> +                       pt_attr.transfer =3D 1;
> +       }
> +       /* Enable relaxed matching for better performance */
> +       pt_attr.relaxed_matching =3D 1;
> +
> +       memset(pattern, 0, sizeof(pattern));
> +       memset(actions, 0, sizeof(actions));
> +       memset(action_masks, 0, sizeof(action_masks));
> +
> +       /* Fill templates and gather per-item/action sizes */
> +       fill_items_template(pattern, flow_items, 0, 0, item_spec_sizes,
> &n_items);
> +
> +       at_attr.ingress =3D pt_attr.ingress;
> +       at_attr.egress =3D pt_attr.egress;
> +       at_attr.transfer =3D pt_attr.transfer;
> +
> +       fill_actions_template(actions, action_masks, flow_actions,
> &port_attr,
> +                             &need_wire_orig_table, action_conf_sizes,
> &n_actions);
> +
> +       /* fill_actions_template count the number of actions that require
> each kind of object,
> +        * so we multiply by the number of rules to have correct number *=
/
> +       port_attr.nb_counters *=3D rules_count;
> +       port_attr.nb_aging_objects *=3D rules_count;
> +       port_attr.nb_meters *=3D rules_count;
> +       port_attr.nb_conn_tracks *=3D rules_count;
> +       port_attr.nb_quotas *=3D rules_count;
> +
> +       table_attr.flow_attr.group =3D flow_group;
> +       table_attr.flow_attr.priority =3D 0;
> +       table_attr.flow_attr.ingress =3D pt_attr.ingress;
> +       table_attr.flow_attr.egress =3D pt_attr.egress;
> +       table_attr.flow_attr.transfer =3D pt_attr.transfer;
> +       table_attr.nb_flows =3D rules_count;
> +
> +       if (pt_attr.transfer && need_wire_orig_table)
> +               table_attr.specialize =3D
> RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG;
> +
> +       queue_attr_list =3D malloc(sizeof(*queue_attr_list) * nb_queues);
> +       if (queue_attr_list =3D=3D NULL) {
> +               fprintf(stderr, "Port %u: failed to allocate
> queue_attr_list\n", port_id);
> +               return -ENOMEM;
> +       }
> +
> +       queue_attr.size =3D queue_size;
> +       for (i =3D 0; i < nb_queues; i++)
> +               queue_attr_list[i] =3D &queue_attr;
> +
> +       ret =3D rte_flow_configure(port_id, &port_attr, nb_queues,
> queue_attr_list, &error);
> +
> +       free(queue_attr_list);
> +
> +       if (ret !=3D 0) {
> +               fprintf(stderr, "Port %u: rte_flow_configure failed
> (ret=3D%d, type=3D%d): %s\n",
> +                       port_id, ret, error.type, error.message ?
> error.message : "(no message)");
> +               return ret;
> +       }
> +
> +       /* Create pattern template */
> +       res->pattern_template =3D
> +               rte_flow_pattern_template_create(port_id, &pt_attr,
> pattern, &error);
> +       if (res->pattern_template =3D=3D NULL) {
> +               fprintf(stderr, "Port %u: pattern template create failed:
> %s\n", port_id,
> +                       error.message ? error.message : "(no message)");
> +               return -1;
> +       }
> +
> +       /* Create actions template */
> +       res->actions_template =3D
> +               rte_flow_actions_template_create(port_id, &at_attr,
> actions, action_masks, &error);
> +       if (res->actions_template =3D=3D NULL) {
> +               fprintf(stderr, "Port %u: actions template create failed:
> %s\n", port_id,
> +                       error.message ? error.message : "(no message)");
> +               rte_flow_pattern_template_destroy(port_id,
> res->pattern_template, &error);
> +               res->pattern_template =3D NULL;
> +               return -1;
> +       }
> +
> +       /* Create template table */
> +       res->table =3D rte_flow_template_table_create(port_id, &table_att=
r,
> &res->pattern_template, 1,
> +
>  &res->actions_template, 1, &error);
> +       if (res->table =3D=3D NULL) {
> +               fprintf(stderr, "Port %u: template table create failed:
> %s\n", port_id,
> +                       error.message ? error.message : "(no message)");
> +               rte_flow_actions_template_destroy(port_id,
> res->actions_template, &error);
> +               rte_flow_pattern_template_destroy(port_id,
> res->pattern_template, &error);
> +               res->pattern_template =3D NULL;
> +               res->actions_template =3D NULL;
> +               return -1;
> +       }
> +
> +       /* Allocate and pre-initialize per-slot flat buffers */
> +       ret =3D init_slot_pool(res, nb_queues, queue_size, pattern, n_ite=
ms,
> item_spec_sizes, actions,
> +                            n_actions, action_conf_sizes);
> +       if (ret !=3D 0) {
> +               fprintf(stderr, "Port %u: slot pool init failed\n",
> port_id);
> +               rte_flow_template_table_destroy(port_id, res->table,
> &error);
> +               rte_flow_actions_template_destroy(port_id,
> res->actions_template, &error);
> +               rte_flow_pattern_template_destroy(port_id,
> res->pattern_template, &error);
> +               res->table =3D NULL;
> +               res->actions_template =3D NULL;
> +               res->pattern_template =3D NULL;
> +               return ret;
> +       }
> +
> +       res->table_capacity =3D rules_count;
> +       res->initialized =3D true;
> +
> +       printf(":: Port %u: Async flow engine initialized (queues=3D%u,
> queue_size=3D%u)\n", port_id,
> +              nb_queues, queue_size);
> +
> +       return 0;
> +}
> +
> +struct rte_flow *
> +async_generate_flow(uint16_t port_id, uint32_t queue_id, uint32_t
> counter, uint16_t hairpinq,
> +                   uint64_t encap_data, uint64_t decap_data, uint16_t
> dst_port, uint8_t core_idx,
> +                   uint8_t rx_queues_count, bool unique_data, bool
> postpone,
> +                   struct rte_flow_error *error)
> +{
> +       struct async_flow_resources *res;
> +       struct async_flow_queue *q;
> +       uint8_t *slot;
> +       uint32_t idx, items_array_bytes;
> +       struct rte_flow_item *items;
> +       struct rte_flow_action *actions;
> +       struct rte_flow_op_attr op_attr =3D {
> +               .postpone =3D postpone,
> +       };
> +
> +       if (port_id >=3D MAX_PORTS) {
> +               rte_flow_error_set(error, EINVAL,
> RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                                  "Invalid port ID");
> +               return NULL;
> +       }
> +
> +       res =3D &port_resources[port_id];
> +       if (!res->initialized) {
> +               rte_flow_error_set(error, EINVAL,
> RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                                  "Async flow resources not initialized"=
);
> +               return NULL;
> +       }
> +
> +       if (queue_id >=3D res->nb_queues) {
> +               rte_flow_error_set(error, EINVAL,
> RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                                  "Invalid queue ID");
> +               return NULL;
> +       }
> +
> +       /* Pick the next slot from this queue's ring */
> +       q =3D &res->queues[queue_id];
> +       idx =3D q->head;
> +       q->head =3D (idx + 1) & (res->slots_per_queue - 1);
> +       slot =3D q->slots + (size_t)idx * res->slot_size;
> +       items_array_bytes =3D res->n_items * sizeof(struct rte_flow_item)=
;
> +       items =3D (struct rte_flow_item *)slot;
> +       actions =3D (struct rte_flow_action *)(slot + items_array_bytes);
> +
> +       /* Update only per-flow varying values */
> +       update_item_values(items, counter);
> +       update_action_values(actions, counter, hairpinq, encap_data,
> decap_data, core_idx,
> +                            unique_data, rx_queues_count, dst_port);
> +
> +       return rte_flow_async_create(port_id, queue_id, &op_attr,
> res->table, items, 0, actions, 0,
> +                                    NULL, error);
> +}
> +
> +void
> +async_flow_cleanup_port(uint16_t port_id)
> +{
> +       struct async_flow_resources *res;
> +       struct rte_flow_error error;
> +       struct rte_flow_op_result results[64];
> +       int ret, i;
> +
> +       if (port_id >=3D MAX_PORTS)
> +               return;
> +
> +       res =3D &port_resources[port_id];
> +       if (!res->initialized)
> +               return;
> +
> +       /* Drain any pending async completions from flow flush */
> +       for (i =3D 0; i < DRAIN_MAX_ITERATIONS; i++) {
> +               rte_flow_push(port_id, 0, &error);
> +               ret =3D rte_flow_pull(port_id, 0, results, 64, &error);
> +               if (ret <=3D 0)
> +                       break;
> +       }
> +
> +       if (res->table !=3D NULL) {
> +               rte_flow_template_table_destroy(port_id, res->table,
> &error);
> +               res->table =3D NULL;
> +       }
> +
> +       if (res->actions_template !=3D NULL) {
> +               rte_flow_actions_template_destroy(port_id,
> res->actions_template, &error);
> +               res->actions_template =3D NULL;
> +       }
> +
> +       if (res->pattern_template !=3D NULL) {
> +               rte_flow_pattern_template_destroy(port_id,
> res->pattern_template, &error);
> +               res->pattern_template =3D NULL;
> +       }
> +
> +       free(res->queues);
> +       res->queues =3D NULL;
> +       free(res->slot_pool);
> +       res->slot_pool =3D NULL;
> +       free(res->shared_masks);
> +       res->shared_masks =3D NULL;
> +
> +       res->initialized =3D false;
> +}
> diff --git a/app/test-flow-perf/async_flow.h
> b/app/test-flow-perf/async_flow.h
> new file mode 100644
> index 0000000000..8c12924bc6
> --- /dev/null
> +++ b/app/test-flow-perf/async_flow.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright 2026 Maxime Peim <maxime.peim@gmail.com>
> + *
> + * This file contains the async flow API related definitions
> + * and function declarations.
> + */
> +
> +#ifndef FLOW_PERF_ASYNC_FLOW
> +#define FLOW_PERF_ASYNC_FLOW
> +
> +#include <rte_flow.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +#include "config.h"
> +
> +/* Per-queue slot ring =E2=80=94 tracks which slot to use next */
> +struct async_flow_queue {
> +       uint8_t *slots; /* pointer to this queue's region within slot_poo=
l
> */
> +       uint32_t head;  /* next slot index (wraps mod slots_per_queue) */
> +};
> +
> +/* Per-port async flow resources */
> +struct async_flow_resources {
> +       struct rte_flow_pattern_template *pattern_template;
> +       struct rte_flow_actions_template *actions_template;
> +       struct rte_flow_template_table *table;
> +       uint8_t *slot_pool;    /* flat buffer pool for all slots */
> +       uint8_t *shared_masks; /* shared item mask data (one copy for all
> slots) */
> +       struct async_flow_queue *queues;
> +       uint32_t slot_size;       /* bytes per slot (cache-line aligned) =
*/
> +       uint32_t slots_per_queue; /* =3D queue_size */
> +       uint32_t nb_queues;
> +       uint32_t n_items;   /* item count (excl. END) */
> +       uint32_t n_actions; /* action count (excl. END) */
> +       uint32_t table_capacity;
> +       bool initialized;
> +};
> +
> +/* Initialize async flow engine for a port */
> +int async_flow_init_port(uint16_t port_id, uint32_t nb_queues, uint32_t
> queue_size,
> +                        uint64_t *flow_items, uint64_t *flow_actions,
> uint64_t *flow_attrs,
> +                        uint8_t flow_group, uint32_t rules_count);
> +
> +/* Create a flow rule asynchronously using pre-allocated slot */
> +struct rte_flow *async_generate_flow(uint16_t port_id, uint32_t queue_id=
,
> uint32_t counter,
> +                                    uint16_t hairpinq, uint64_t
> encap_data, uint64_t decap_data,
> +                                    uint16_t dst_port, uint8_t core_idx,
> uint8_t rx_queues_count,
> +                                    bool unique_data, bool postpone,
> struct rte_flow_error *error);
> +
> +/* Cleanup async flow resources for a port */
> +void async_flow_cleanup_port(uint16_t port_id);
> +
> +#endif /* FLOW_PERF_ASYNC_FLOW */
> diff --git a/app/test-flow-perf/items_gen.c
> b/app/test-flow-perf/items_gen.c
> index c740e1838f..58f1c16cf8 100644
> --- a/app/test-flow-perf/items_gen.c
> +++ b/app/test-flow-perf/items_gen.c
> @@ -389,3 +389,61 @@ fill_items(struct rte_flow_item *items,
>
>         items[items_counter].type =3D RTE_FLOW_ITEM_TYPE_END;
>  }
> +
> +static size_t
> +item_spec_size(enum rte_flow_item_type type)
> +{
> +       switch (type) {
> +       case RTE_FLOW_ITEM_TYPE_ETH:
> +               return sizeof(struct rte_flow_item_eth);
> +       case RTE_FLOW_ITEM_TYPE_VLAN:
> +               return sizeof(struct rte_flow_item_vlan);
> +       case RTE_FLOW_ITEM_TYPE_IPV4:
> +               return sizeof(struct rte_flow_item_ipv4);
> +       case RTE_FLOW_ITEM_TYPE_IPV6:
> +               return sizeof(struct rte_flow_item_ipv6);
> +       case RTE_FLOW_ITEM_TYPE_TCP:
> +               return sizeof(struct rte_flow_item_tcp);
> +       case RTE_FLOW_ITEM_TYPE_UDP:
> +               return sizeof(struct rte_flow_item_udp);
> +       case RTE_FLOW_ITEM_TYPE_VXLAN:
> +               return sizeof(struct rte_flow_item_vxlan);
> +       case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
> +               return sizeof(struct rte_flow_item_vxlan_gpe);
> +       case RTE_FLOW_ITEM_TYPE_GRE:
> +               return sizeof(struct rte_flow_item_gre);
> +       case RTE_FLOW_ITEM_TYPE_GENEVE:
> +               return sizeof(struct rte_flow_item_geneve);
> +       case RTE_FLOW_ITEM_TYPE_GTP:
> +               return sizeof(struct rte_flow_item_gtp);
> +       case RTE_FLOW_ITEM_TYPE_META:
> +               return sizeof(struct rte_flow_item_meta);
> +       case RTE_FLOW_ITEM_TYPE_TAG:
> +               return sizeof(struct rte_flow_item_tag);
> +       case RTE_FLOW_ITEM_TYPE_ICMP:
> +               return sizeof(struct rte_flow_item_icmp);
> +       case RTE_FLOW_ITEM_TYPE_ICMP6:
> +               return sizeof(struct rte_flow_item_icmp6);
> +       default:
> +               return 0;
> +       }
> +}
> +
> +void
> +fill_items_template(struct rte_flow_item *items, uint64_t *flow_items,
> uint32_t outer_ip_src,
> +                   uint8_t core_idx, size_t *spec_sizes, uint32_t
> *n_items_out)
> +{
> +       uint32_t count;
> +
> +       fill_items(items, flow_items, outer_ip_src, core_idx);
> +
> +       /* Count items before END */
> +       for (count =3D 0; items[count].type !=3D RTE_FLOW_ITEM_TYPE_END;
> count++) {
> +               spec_sizes[count] =3D item_spec_size(items[count].type);
> +               /* For templates, set spec to NULL - only mask matters fo=
r
> template matching */
> +               items[count].spec =3D NULL;
> +       }
> +
> +       /* take END into account */
> +       *n_items_out =3D count + 1;
> +}
> diff --git a/app/test-flow-perf/items_gen.h
> b/app/test-flow-perf/items_gen.h
> index f4b0e9a981..0987f7be3c 100644
> --- a/app/test-flow-perf/items_gen.h
> +++ b/app/test-flow-perf/items_gen.h
> @@ -15,4 +15,10 @@
>  void fill_items(struct rte_flow_item *items, uint64_t *flow_items,
>         uint32_t outer_ip_src, uint8_t core_idx);
>
> +/* Fill items template for async flow API (masks only, no spec values).
> + * If spec_sizes is non-NULL, populates per-item spec sizes and
> n_items_out.
> + */
> +void fill_items_template(struct rte_flow_item *items, uint64_t
> *flow_items, uint32_t outer_ip_src,
> +                        uint8_t core_idx, size_t *spec_sizes, uint32_t
> *n_items_out);
> +
>  #endif /* FLOW_PERF_ITEMS_GEN */
> diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
> index 6636d1517f..2c6def95c2 100644
> --- a/app/test-flow-perf/main.c
> +++ b/app/test-flow-perf/main.c
> @@ -37,11 +37,15 @@
>  #include <rte_mtr.h>
>  #include <rte_os_shim.h>
>
> -#include "config.h"
>  #include "actions_gen.h"
> +#include "async_flow.h"
> +#include "config.h"
>  #include "flow_gen.h"
> +#include "rte_build_config.h"
>
>  #define MAX_BATCHES_COUNT          100
> +#define MAX_ASYNC_QUEUE_SIZE        (1 << 14)
> +#define MAX_PULL_RETRIES            (1 << 20)
>  #define DEFAULT_RULES_COUNT    4000000
>  #define DEFAULT_RULES_BATCH     100000
>  #define DEFAULT_GROUP                0
> @@ -55,7 +59,6 @@
>  #define HAIRPIN_TX_CONF_LOCKED_MEMORY (0x0100)
>  #define HAIRPIN_TX_CONF_RTE_MEMORY    (0x0200)
>
> -struct rte_flow *flow;
>  static uint8_t flow_group;
>
>  static uint64_t encap_data;
> @@ -81,6 +84,9 @@ static bool enable_fwd;
>  static bool unique_data;
>  static bool policy_mtr;
>  static bool packet_mode;
> +static bool async_mode;
> +static uint32_t async_queue_size =3D 1024;
> +static uint32_t async_push_batch =3D 256;
>
>  static uint8_t rx_queues_count;
>  static uint8_t tx_queues_count;
> @@ -598,6 +604,29 @@ usage(char *progname)
>                 "Encapped data is fixed with pattern:
> ether,ipv4,udp,vxlan\n"
>                 "With fixed values\n");
>         printf("  --vxlan-decap: add vxlan_decap action to flow
> actions\n");
> +
> +       printf("\nAsync flow API options:\n");
> +       printf("  --async: enable async flow API mode\n");
> +       printf("  --async-queue-size=3DN: size of each async queue,"
> +              " default is 1024\n");
> +       printf("  --async-push-batch=3DN: flows to batch before push,"
> +              " default is 256\n");
> +}
> +
> +static inline uint32_t
> +prev_power_of_two(uint32_t x)
> +{
> +       uint32_t saved =3D x;
> +       x--;
> +       x |=3D x >> 1;
> +       x |=3D x >> 2;
> +       x |=3D x >> 4;
> +       x |=3D x >> 8;
> +       x |=3D x >> 16;
> +       x++;
> +       if (x =3D=3D saved)
> +               return x;
> +       return x >> 1;
>  }
>
>  static void
> @@ -734,6 +763,9 @@ args_parse(int argc, char **argv)
>                 { "policy-mtr",                 1, 0, 0 },
>                 { "meter-profile",              1, 0, 0 },
>                 { "packet-mode",                0, 0, 0 },
> +               { "async",                      0, 0, 0 },
> +               { "async-queue-size",           1, 0, 0 },
> +               { "async-push-batch",           1, 0, 0 },
>                 { 0, 0, 0, 0 },
>         };
>
> @@ -913,8 +945,7 @@ args_parse(int argc, char **argv)
>                                         rte_exit(EXIT_FAILURE, "Invalid
> hairpin config mask\n");
>                                 hairpin_conf_mask =3D hp_conf;
>                         }
> -                       if (strcmp(lgopts[opt_idx].name,
> -                                       "port-id") =3D=3D 0) {
> +                       if (strcmp(lgopts[opt_idx].name, "port-id") =3D=
=3D 0) {
>                                 uint16_t port_idx =3D 0;
>
>                                 token =3D strtok(optarg, ",");
> @@ -981,6 +1012,26 @@ args_parse(int argc, char **argv)
>                         }
>                         if (strcmp(lgopts[opt_idx].name, "packet-mode") =
=3D=3D
> 0)
>                                 packet_mode =3D true;
> +                       if (strcmp(lgopts[opt_idx].name, "async") =3D=3D =
0)
> +                               async_mode =3D true;
> +                       if (strcmp(lgopts[opt_idx].name,
> "async-queue-size") =3D=3D 0) {
> +                               n =3D atoi(optarg);
> +                               if (n >=3D MAX_ASYNC_QUEUE_SIZE)
> +                                       async_queue_size =3D
> MAX_ASYNC_QUEUE_SIZE;
> +                               else if (n > 0)
> +                                       async_queue_size =3D
> prev_power_of_two(n);
> +                               else
> +                                       rte_exit(EXIT_FAILURE,
> "async-queue-size should be > 0\n");
> +                       }
> +                       if (strcmp(lgopts[opt_idx].name,
> "async-push-batch") =3D=3D 0) {
> +                               n =3D atoi(optarg);
> +                               if (n >=3D MAX_ASYNC_QUEUE_SIZE >> 1)
> +                                       async_push_batch =3D
> MAX_ASYNC_QUEUE_SIZE >> 1;
> +                               else if (n > 0)
> +                                       async_push_batch =3D
> prev_power_of_two(n);
> +                               else
> +                                       rte_exit(EXIT_FAILURE,
> "async-push-batch should be > 0\n");
> +                       }
>                         break;
>                 default:
>                         usage(argv[0]);
> @@ -1457,10 +1508,10 @@ query_flows(int port_id, uint8_t core_id, struct
> rte_flow **flows_list)
>         mc_pool.flows_record.query[port_id][core_id] =3D cpu_time_used;
>  }
>
> -static struct rte_flow **
> -insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
> +static void
> +insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id, struct
> rte_flow **flows_list)
>  {
> -       struct rte_flow **flows_list;
> +       struct rte_flow *flow;
>         struct rte_flow_error error;
>         clock_t start_batch, end_batch;
>         double first_flow_latency;
> @@ -1485,8 +1536,7 @@ insert_flows(int port_id, uint8_t core_id, uint16_t
> dst_port_id)
>         global_items[0] =3D FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_ETH);
>         global_actions[0] =3D FLOW_ITEM_MASK(RTE_FLOW_ACTION_TYPE_JUMP);
>
> -       flows_list =3D rte_zmalloc("flows_list",
> -               (sizeof(struct rte_flow *) * (rules_count_per_core + 1)),
> 0);
> +       flows_list =3D malloc(sizeof(struct rte_flow *) *
> (rules_count_per_core + 1));
>         if (flows_list =3D=3D NULL)
>                 rte_exit(EXIT_FAILURE, "No Memory available!\n");
>
> @@ -1524,6 +1574,11 @@ insert_flows(int port_id, uint8_t core_id, uint16_=
t
> dst_port_id)
>                         core_id, rx_queues_count,
>                         unique_data, max_priority, &error);
>
> +               if (!flow) {
> +                       print_flow_error(error);
> +                       rte_exit(EXIT_FAILURE, "Error in creating flow\n"=
);
> +               }
> +
>                 if (!counter) {
>                         first_flow_latency =3D (double)
> (rte_get_timer_cycles() - start_batch);
>                         first_flow_latency /=3D rte_get_timer_hz();
> @@ -1537,11 +1592,6 @@ insert_flows(int port_id, uint8_t core_id, uint16_=
t
> dst_port_id)
>                 if (force_quit)
>                         counter =3D end_counter;
>
> -               if (!flow) {
> -                       print_flow_error(error);
> -                       rte_exit(EXIT_FAILURE, "Error in creating flow\n"=
);
> -               }
> -
>                 flows_list[flow_index++] =3D flow;
>
>                 /*
> @@ -1575,7 +1625,203 @@ insert_flows(int port_id, uint8_t core_id,
> uint16_t dst_port_id)
>                 port_id, core_id, rules_count_per_core, cpu_time_used);
>
>         mc_pool.flows_record.insertion[port_id][core_id] =3D cpu_time_use=
d;
> -       return flows_list;
> +}
> +
> +static uint32_t push_counter[RTE_MAX_LCORE];
> +
> +static inline int
> +push_pull_flows_async(int port_id, int queue_id, int core_id, uint32_t
> enqueued, bool empty,
> +                     bool check_op_status, struct rte_flow_error *error)
> +{
> +       static struct rte_flow_op_result
> results[RTE_MAX_LCORE][MAX_ASYNC_QUEUE_SIZE];
> +       uint32_t to_pull =3D (empty || async_push_batch > enqueued) ?
> enqueued : async_push_batch;
> +       uint32_t pulled_complete =3D 0;
> +       uint32_t retries =3D 0;
> +       int pulled, i;
> +       int ret =3D 0;
> +
> +       /* Push periodically to give HW work to do */
> +       ret =3D rte_flow_push(port_id, queue_id, error);
> +       if (ret)
> +               return ret;
> +       push_counter[core_id]++;
> +
> +       /* Check if queue is getting full, if so push and drain
> completions */
> +       if (!empty && push_counter[core_id] =3D=3D 1)
> +               return 0;
> +
> +       while (to_pull > 0) {
> +               pulled =3D rte_flow_pull(port_id, queue_id,
> results[core_id], to_pull, error);
> +               if (pulled < 0) {
> +                       return -1;
> +               } else if (pulled =3D=3D 0) {
> +                       if (++retries > MAX_PULL_RETRIES) {
> +                               rte_flow_error_set(error, ETIMEDOUT,
> +
> RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                                                  "Timeout waiting for
> async completions");
> +                               return -1;
> +                       }
> +                       rte_pause();
> +                       continue;
> +               }
> +               retries =3D 0;
> +
> +               to_pull -=3D pulled;
> +               pulled_complete +=3D pulled;
> +               if (!check_op_status)
> +                       continue;
> +
> +               for (i =3D 0; i < pulled; i++) {
> +                       if (results[core_id][i].status !=3D
> RTE_FLOW_OP_SUCCESS) {
> +                               rte_flow_error_set(error, EINVAL,
> RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> +                                                  NULL, "Some flow rule
> insertion failed");
> +                               return -1;
> +                       }
> +               }
> +       }
> +
> +       return pulled_complete;
> +}
> +
> +static void
> +insert_flows_async(int port_id, uint8_t core_id, uint16_t dst_port_id,
> struct rte_flow **flows_list)
> +{
> +       struct rte_flow *flow;
> +       struct rte_flow_error error;
> +       clock_t start_batch, end_batch;
> +       double first_flow_latency;
> +       double cpu_time_used;
> +       double insertion_rate;
> +       double cpu_time_per_batch[MAX_BATCHES_COUNT] =3D {0};
> +       double delta;
> +       uint32_t flow_index;
> +       uint32_t counter, batch_counter, start_counter =3D 0, end_counter=
;
> +       int rules_batch_idx;
> +       int rules_count_per_core;
> +       uint32_t enqueued =3D 0;
> +       uint32_t queue_id =3D core_id;
> +       bool first_batch =3D true;
> +       int pulled;
> +
> +       rules_count_per_core =3D rules_count / mc_pool.cores_count;
> +
> +       if (async_push_batch > async_queue_size >> 1)
> +               async_push_batch =3D async_queue_size >> 1;
> +
> +       /* Set boundaries of rules for each core. */
> +       if (core_id)
> +               start_counter =3D core_id * rules_count_per_core;
> +       end_counter =3D (core_id + 1) * rules_count_per_core;
> +
> +       cpu_time_used =3D 0;
> +       flow_index =3D 0;
> +       push_counter[core_id] =3D 0;
> +
> +       if (flow_group > 0 && core_id =3D=3D 0) {
> +               /*
> +                * Create global rule to jump into flow_group,
> +                * this way the app will avoid the default rules.
> +                *
> +                * This rule will be created only once.
> +                *
> +                * Global rule:
> +                * group 0 eth / end actions jump group <flow_group>
> +                */
> +
> +               uint64_t global_items[MAX_ITEMS_NUM] =3D {0};
> +               uint64_t global_actions[MAX_ACTIONS_NUM] =3D {0};
> +               global_items[0] =3D FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_ETH=
);
> +               global_actions[0] =3D
> FLOW_ITEM_MASK(RTE_FLOW_ACTION_TYPE_JUMP);
> +               flow =3D generate_flow(port_id, 0, flow_attrs, global_ite=
ms,
> global_actions,
> +                                    flow_group, 0, 0, 0, 0, dst_port_id,
> core_id, rx_queues_count,
> +                                    unique_data, max_priority, &error);
> +
> +               if (flow =3D=3D NULL) {
> +                       print_flow_error(error);
> +                       rte_exit(EXIT_FAILURE, "Error in creating flow\n"=
);
> +               }
> +               flows_list[flow_index++] =3D flow;
> +       }
> +
> +       start_batch =3D rte_get_timer_cycles();
> +       for (counter =3D start_counter; counter < end_counter;) {
> +               /* batch adding flow rules, this avoids unnecessary check=
s
> for push/pull */
> +               for (batch_counter =3D 0; batch_counter < async_push_batc=
h
> && counter < end_counter;
> +                    batch_counter++, counter++) {
> +                       /* Create flow with postpone=3Dtrue to batch
> operations */
> +                       flow =3D async_generate_flow(port_id, queue_id,
> counter, hairpin_queues_num,
> +                                                  encap_data, decap_data=
,
> dst_port_id, core_id,
> +                                                  rx_queues_count,
> unique_data, true, &error);
> +
> +                       if (!flow) {
> +                               print_flow_error(error);
> +                               rte_exit(EXIT_FAILURE, "Error in creating
> async flow\n");
> +                       }
> +
> +                       if (force_quit)
> +                               break;
> +
> +                       flows_list[flow_index++] =3D flow;
> +                       enqueued++;
> +
> +                       /*
> +                        * Save the insertion rate for rules batch.
> +                        * Check if the insertion reached the rules
> +                        * patch counter, then save the insertion rate
> +                        * for this batch.
> +                        */
> +                       if (!((counter + 1) % rules_batch)) {
> +                               end_batch =3D rte_get_timer_cycles();
> +                               delta =3D (double)(end_batch - start_batc=
h);
> +                               rules_batch_idx =3D ((counter + 1) /
> rules_batch) - 1;
> +                               cpu_time_per_batch[rules_batch_idx] =3D
> delta / rte_get_timer_hz();
> +                               cpu_time_used +=3D
> cpu_time_per_batch[rules_batch_idx];
> +                               start_batch =3D rte_get_timer_cycles();
> +                       }
> +               }
> +
> +               if ((pulled =3D push_pull_flows_async(port_id, queue_id,
> core_id, enqueued, false,
> +                                                   true, &error)) < 0) {
> +                       print_flow_error(error);
> +                       rte_exit(EXIT_FAILURE, "Error push/pull async
> operations\n");
> +               }
> +
> +               enqueued -=3D pulled;
> +
> +               if (first_batch) {
> +                       first_flow_latency =3D
> (double)(rte_get_timer_cycles() - start_batch);
> +                       first_flow_latency /=3D rte_get_timer_hz();
> +                       /* In millisecond */
> +                       first_flow_latency *=3D 1000;
> +                       printf(":: First Flow Batch Latency (Async) ::
> Port %d :: First batch (%u) "
> +                              "installed in %f milliseconds\n",
> +                              port_id, async_push_batch,
> first_flow_latency);
> +                       first_batch =3D false;
> +               }
> +       }
> +
> +       if (push_pull_flows_async(port_id, queue_id, core_id, enqueued,
> true, true, &error) < 0) {
> +               print_flow_error(error);
> +               rte_exit(EXIT_FAILURE, "Error final push/pull async
> operations\n");
> +       }
> +
> +       /* Print insertion rates for all batches */
> +       if (dump_iterations)
> +               print_rules_batches(cpu_time_per_batch);
> +
> +       printf(":: Port %d :: Core %d boundaries (Async) :: start @[%d] -
> end @[%d]\n", port_id,
> +              core_id, start_counter, end_counter - 1);
> +
> +       /* Insertion rate for all rules in one core */
> +       if (cpu_time_used > 0) {
> +               insertion_rate =3D ((double)rules_count_per_core /
> cpu_time_used) / 1000;
> +               printf(":: Port %d :: Core %d :: Async rules insertion
> rate -> %f K Rule/Sec\n",
> +                      port_id, core_id, insertion_rate);
> +       }
> +       printf(":: Port %d :: Core %d :: The time for creating %d async
> rules is %f seconds\n",
> +              port_id, core_id, rules_count_per_core, cpu_time_used);
> +
> +       mc_pool.flows_record.insertion[port_id][core_id] =3D cpu_time_use=
d;
>  }
>
>  static void
> @@ -1585,12 +1831,18 @@ flows_handler(uint8_t core_id)
>         uint16_t port_idx =3D 0;
>         uint16_t nr_ports;
>         int port_id;
> +       int rules_count_per_core;
>
>         nr_ports =3D rte_eth_dev_count_avail();
>
>         if (rules_batch > rules_count)
>                 rules_batch =3D rules_count;
>
> +       rules_count_per_core =3D rules_count / mc_pool.cores_count;
> +       flows_list =3D malloc(sizeof(struct rte_flow *) *
> (rules_count_per_core + 1));
> +       if (flows_list =3D=3D NULL)
> +               rte_exit(EXIT_FAILURE, "No Memory available!\n");
> +
>         printf(":: Rules Count per port: %d\n\n", rules_count);
>
>         for (port_id =3D 0; port_id < nr_ports; port_id++) {
> @@ -1602,10 +1854,10 @@ flows_handler(uint8_t core_id)
>                 mc_pool.last_alloc[core_id] =3D
> (int64_t)dump_socket_mem(stdout);
>                 if (has_meter())
>                         meters_handler(port_id, core_id, METER_CREATE);
> -               flows_list =3D insert_flows(port_id, core_id,
> -                                               dst_ports[port_idx++]);
> -               if (flows_list =3D=3D NULL)
> -                       rte_exit(EXIT_FAILURE, "Error: Insertion
> Failed!\n");
> +               if (async_mode)
> +                       insert_flows_async(port_id, core_id,
> dst_ports[port_idx++], flows_list);
> +               else
> +                       insert_flows(port_id, core_id,
> dst_ports[port_idx++], flows_list);
>                 mc_pool.current_alloc[core_id] =3D
> (int64_t)dump_socket_mem(stdout);
>
>                 if (query_flag)
> @@ -2212,6 +2464,16 @@ init_port(void)
>                         }
>                 }
>
> +               /* Configure async flow engine before device start */
> +               if (async_mode) {
> +                       ret =3D async_flow_init_port(port_id,
> mc_pool.cores_count, async_queue_size,
> +                                                  flow_items,
> flow_actions, flow_attrs, flow_group,
> +                                                  rules_count);
> +                       if (ret !=3D 0)
> +                               rte_exit(EXIT_FAILURE, "Failed to init
> async flow on port %d\n",
> +                                        port_id);
> +               }
> +
>                 ret =3D rte_eth_dev_start(port_id);
>                 if (ret < 0)
>                         rte_exit(EXIT_FAILURE,
> @@ -2291,6 +2553,8 @@ main(int argc, char **argv)
>
>         RTE_ETH_FOREACH_DEV(port) {
>                 rte_flow_flush(port, &error);
> +               if (async_mode)
> +                       async_flow_cleanup_port(port);
>                 if (rte_eth_dev_stop(port) !=3D 0)
>                         printf("Failed to stop device on port %u\n", port=
);
>                 rte_eth_dev_close(port);
> diff --git a/app/test-flow-perf/meson.build
> b/app/test-flow-perf/meson.build
> index e101449e32..2f820a7597 100644
> --- a/app/test-flow-perf/meson.build
> +++ b/app/test-flow-perf/meson.build
> @@ -3,6 +3,7 @@
>
>  sources =3D files(
>          'actions_gen.c',
> +        'async_flow.c',
>          'flow_gen.c',
>          'items_gen.c',
>          'main.c',
> --
> 2.43.0
>
>

--0000000000001117a8064bfef186
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgU3RlcGhlbiw8YnI+PGJyPlRoYW5rcyBmb3IgdGhlIHJldmlldyE8
YnI+U29tZSBvZsKgIHRoZSBBSSBnZW5lcmF0ZWQgY29tbWVudHMgd2VyZSBpbmRlZWQgaXNzdWVz
LCBidXQgYWxyZWFkeSB0aGVyZSBiZWZvcmUgbXkgY2hhbmdlcyAodGhlIGdsb2JhbCBmbG93IHZh
cmlhYmxlIGZvciBleGFtcGxlKS48ZGl2PlNvIEkgdXBkYXRlZCBteSBjaGFuZ2VzIHRvIGZpeCB0
aG9zZSBuZXZlcnRoZWxlc3MuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5MZXQgbWUga25vdyBp
ZiBhbnkgb3RoZXIgY2hhbmdlcyBhcmUgbmVlZGVkLjwvZGl2PjxkaXY+QWxzbywgSSBoYXZlIG1h
ZGUgaW1wcm92ZW1lbnQgYnkgcHJlLWFsbG9jYXRpbmcgYSBtZW1vcnkgcG9vbCBmb3IgYXN5bmMg
Zmxvd3M6PC9kaXY+PGRpdj7CoC0gaXQgYXZvaWQgZXZlcnkgaW4tZmxpZ2h0IGZsb3cgaW4gdGhl
IHF1ZXVlIHRvIHBvaW50IHRvIHRoZSBzYW1lIGl0ZW1zIC8gYWN0aW9ucyB3aGVuIHVzaW5nIHN0
YXRpYyB2YXJpYWJsZXM8L2Rpdj48ZGl2PsKgLSBpdCBhbGxvd3MgYmV0dGVyIGxvY2FsaXR5IGFu
ZCBjYWNoZSB1c2FnZTwvZGl2PjxkaXY+V2l0aCB0aGlzIGNoYW5nZSBJIHdhcyBhYmxlIHRvIGRv
dWJsZSB0aGUgbnVtYmVyIG9mIGZsb3dzIEkgY2FuIGluc2VydCBvbiBhIEJGMy48L2Rpdj48L2Rp
dj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFpbmVyIj48ZGl2
IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gTW9uLCBNYXIgMiwgMjAyNiBhdCAxMjoy
OeKAr0FNIE1heGltZSBQZWltICZsdDs8YSBocmVmPSJtYWlsdG86bWF4aW1lLnBlaW1AZ21haWwu
Y29tIj5tYXhpbWUucGVpbUBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
PkFkZCBhc3luYyBmbG93IEFQSSBtb2RlIHRvIHRlc3QtZmxvdy1wZXJmIGFwcGxpY2F0aW9uIGZv
ciBpbXByb3ZlZDxicj4NCmZsb3cgcnVsZSBpbnNlcnRpb24gcGVyZm9ybWFuY2UuIFRoZSBhc3lu
YyBBUEkgYWxsb3dzIGJhdGNoaW5nIGZsb3c8YnI+DQpydWxlIGNyZWF0aW9uIG9wZXJhdGlvbnMg
YW5kIHByb2Nlc3NpbmcgY29tcGxldGlvbnMgaW4gYnVsaywgcmVkdWNpbmc8YnI+DQpwZXItcnVs
ZSBvdmVyaGVhZC48YnI+DQo8YnI+DQpOZXcgY29tbWFuZCBsaW5lIG9wdGlvbnM6PGJyPg0KwqAg
LS1hc3luYzogZW5hYmxlIGFzeW5jIGZsb3cgQVBJIG1vZGU8YnI+DQrCoCAtLWFzeW5jLXF1ZXVl
LXNpemU9Tjogc2l6ZSBvZiBhc3luYyBxdWV1ZXMgKGRlZmF1bHQ6IDEwMjQpPGJyPg0KwqAgLS1h
c3luYy1wdXNoLWJhdGNoPU46IGZsb3dzIHRvIGJhdGNoIGJlZm9yZSBwdXNoIChkZWZhdWx0OiAy
NTYpPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogTWF4aW1lIFBlaW0gJmx0OzxhIGhyZWY9Im1h
aWx0bzptYXhpbWUucGVpbUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5tYXhpbWUucGVpbUBn
bWFpbC5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCnYyOjxicj4NCsKgIC0gUmVwbGFjZSBwZXIt
ZmxvdyBzdGFjayBhbGxvY2F0aW9uIHdpdGggcHJlLWFsbG9jYXRlZCBzbG90IHBvb2w7PGJyPg0K
wqAgwqAgZmxhdCBidWZmZXJzIGFyZSBpbml0aWFsaXplZCBvbmNlIGF0IGluaXQgdGltZSBhbmQg
dGhlIGhvdCBwYXRoPGJyPg0KwqAgwqAgb25seSBwYXRjaGVzIHBlci1mbG93IGl0ZW0vYWN0aW9u
IHZhbHVlcyBpbnRvIGEgcHJlLXNldCBzbG90PGJyPg0KwqAgLSBGaXggYWxsb2NhIG1pc3VzZTog
dXNlIGhlYXAgYWxsb2NhdGlvbiBmb3IgcXVldWVfYXR0cl9saXN0LCByb3VuZDxicj4NCsKgIMKg
IHF1ZXVlX3NpemUgdG8gcG93ZXIgb2YgMiBmb3IgYml0bWFzayB3cmFwcGluZywgYWRkIGJvdW5k
cyBjaGVja3M8YnI+DQrCoCAtIEZpeCByYWNlIG9uIGZpbGUtc2NvcGUgZmxvdyB2YXJpYWJsZSwg
cHJlbWF0dXJlIGxhdGVuY3k8YnI+DQrCoCDCoCBtZWFzdXJlbWVudCwgYW5kIGludGVnZXIgZGl2
aXNpb24gaW4gcmF0ZSBjYWxjdWxhdGlvbjxicj4NCsKgIC0gRHJvcCB1bnJlbGF0ZWQgbGdvcHRz
IHJlZm9ybWF0dGluZzxicj4NCsKgIC0gVXNlIG1hbGxvYyBpbnN0ZWFkIG9mIHJ0ZV96bWFsbG9j
IGZvciBub24tZGF0YXBsYW5lIGFsbG9jYXRpb25zPGJyPg0KwqAgLSBWYXJpb3VzIHJvYnVzdG5l
c3MgYW5kIHN0eWxlIGZpeGVzPGJyPg0KPGJyPg0KwqBhcHAvdGVzdC1mbG93LXBlcmYvYWN0aW9u
c19nZW4uYyB8IDI4MSArKysrKysrKysrKy08YnI+DQrCoGFwcC90ZXN0LWZsb3ctcGVyZi9hY3Rp
b25zX2dlbi5oIHzCoCAzMSArKzxicj4NCsKgYXBwL3Rlc3QtZmxvdy1wZXJmL2FzeW5jX2Zsb3cu
Y8KgIHwgNzYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8YnI+DQrCoGFwcC90ZXN0
LWZsb3ctcGVyZi9hc3luY19mbG93LmjCoCB8wqAgNTQgKysrPGJyPg0KwqBhcHAvdGVzdC1mbG93
LXBlcmYvaXRlbXNfZ2VuLmPCoCDCoHzCoCA1OCArKys8YnI+DQrCoGFwcC90ZXN0LWZsb3ctcGVy
Zi9pdGVtc19nZW4uaMKgIMKgfMKgIMKgNiArPGJyPg0KwqBhcHAvdGVzdC1mbG93LXBlcmYvbWFp
bi5jwqAgwqAgwqAgwqAgfCAzMDIgKysrKysrKysrKystPGJyPg0KwqBhcHAvdGVzdC1mbG93LXBl
cmYvbWVzb24uYnVpbGTCoCDCoHzCoCDCoDEgKzxicj4NCsKgOCBmaWxlcyBjaGFuZ2VkLCAxNDU0
IGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKTxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0
IGFwcC90ZXN0LWZsb3ctcGVyZi9hc3luY19mbG93LmM8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcHAvdGVzdC1mbG93LXBlcmYvYXN5bmNfZmxvdy5oPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBh
L2FwcC90ZXN0LWZsb3ctcGVyZi9hY3Rpb25zX2dlbi5jIGIvYXBwL3Rlc3QtZmxvdy1wZXJmL2Fj
dGlvbnNfZ2VuLmM8YnI+DQppbmRleCA5ZDEwMmUzYWY0Li4yYjhlZGQ1MGM4IDEwMDY0NDxicj4N
Ci0tLSBhL2FwcC90ZXN0LWZsb3ctcGVyZi9hY3Rpb25zX2dlbi5jPGJyPg0KKysrIGIvYXBwL3Rl
c3QtZmxvdy1wZXJmL2FjdGlvbnNfZ2VuLmM8YnI+DQpAQCAtMzYsMjcgKzM2LDcgQEAgc3RydWN0
IGFkZGl0aW9uYWxfcGFyYSB7PGJyPg0KwqAgwqAgwqAgwqAgYm9vbCB1bmlxdWVfZGF0YTs8YnI+
DQrCoH07PGJyPg0KPGJyPg0KLS8qIFN0b3JhZ2UgZm9yIHN0cnVjdCBydGVfZmxvd19hY3Rpb25f
cmF3X2VuY2FwIGluY2x1ZGluZyBleHRlcm5hbCBkYXRhLiAqLzxicj4NCi1zdHJ1Y3QgYWN0aW9u
X3Jhd19lbmNhcF9kYXRhIHs8YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9u
X3Jhd19lbmNhcCBjb25mOzxicj4NCi3CoCDCoCDCoCDCoHVpbnQ4X3QgZGF0YVsxMjhdOzxicj4N
Ci3CoCDCoCDCoCDCoHVpbnQ4X3QgcHJlc2VydmVbMTI4XTs8YnI+DQotwqAgwqAgwqAgwqB1aW50
MTZfdCBpZHg7PGJyPg0KLX07PGJyPg0KLTxicj4NCi0vKiBTdG9yYWdlIGZvciBzdHJ1Y3QgcnRl
X2Zsb3dfYWN0aW9uX3Jhd19kZWNhcCBpbmNsdWRpbmcgZXh0ZXJuYWwgZGF0YS4gKi88YnI+DQot
c3RydWN0IGFjdGlvbl9yYXdfZGVjYXBfZGF0YSB7PGJyPg0KLcKgIMKgIMKgIMKgc3RydWN0IHJ0
ZV9mbG93X2FjdGlvbl9yYXdfZGVjYXAgY29uZjs8YnI+DQotwqAgwqAgwqAgwqB1aW50OF90IGRh
dGFbMTI4XTs8YnI+DQotwqAgwqAgwqAgwqB1aW50MTZfdCBpZHg7PGJyPg0KLX07PGJyPg0KLTxi
cj4NCi0vKiBTdG9yYWdlIGZvciBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX3JzcyBpbmNsdWRpbmcg
ZXh0ZXJuYWwgZGF0YS4gKi88YnI+DQotc3RydWN0IGFjdGlvbl9yc3NfZGF0YSB7PGJyPg0KLcKg
IMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9yc3MgY29uZjs8YnI+DQotwqAgwqAgwqAg
wqB1aW50OF90IGtleVs0MF07PGJyPg0KLcKgIMKgIMKgIMKgdWludDE2X3QgcXVldWVbMTI4XTs8
YnI+DQotfTs8YnI+DQorLyogQ29tcG91bmQgYWN0aW9uIGRhdGEgc3RydWN0cyBkZWZpbmVkIGlu
IGFjdGlvbnNfZ2VuLmggKi88YnI+DQo8YnI+DQrCoHN0YXRpYyB2b2lkPGJyPg0KwqBhZGRfbWFy
ayhzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uICphY3Rpb25zLDxicj4NCkBAIC0xMTY1LDMgKzExNDUs
MjYyIEBAIGZpbGxfYWN0aW9ucyhzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uICphY3Rpb25zLCB1aW50
NjRfdCAqZmxvd19hY3Rpb25zLDxicj4NCsKgIMKgIMKgIMKgIGZyZWUocXVldWVzKTs8YnI+DQrC
oCDCoCDCoCDCoCBmcmVlKGhhaXJwaW5fcXVldWVzKTs8YnI+DQrCoH08YnI+DQorPGJyPg0KK3N0
YXRpYyBzaXplX3Q8YnI+DQorYWN0aW9uX2NvbmZfc2l6ZShlbnVtIHJ0ZV9mbG93X2FjdGlvbl90
eXBlIHR5cGUpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzd2l0Y2ggKHR5cGUpIHs8YnI+DQor
wqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX01BUks6PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dXJuIHNpemVvZihzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX21hcmsp
Ozxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfUVVFVUU6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHNpemVvZihzdHJ1Y3QgcnRlX2Zsb3dfYWN0
aW9uX3F1ZXVlKTs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX0pV
TVA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHNpemVvZihzdHJ1Y3QgcnRl
X2Zsb3dfYWN0aW9uX2p1bXApOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9O
X1RZUEVfUlNTOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3Ry
dWN0IGFjdGlvbl9yc3NfZGF0YSk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJ
T05fVFlQRV9TRVRfTUVUQTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gc2l6
ZW9mKHN0cnVjdCBydGVfZmxvd19hY3Rpb25fc2V0X21ldGEpOzxicj4NCivCoCDCoCDCoCDCoGNh
c2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX1RBRzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXR1cm4gc2l6ZW9mKHN0cnVjdCBydGVfZmxvd19hY3Rpb25fc2V0X3RhZyk7PGJyPg0K
K8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9QT1JUX0lEOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9w
b3J0X2lkKTs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX0NPVU5U
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9m
bG93X2FjdGlvbl9jb3VudCk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05f
VFlQRV9TRVRfTUFDX1NSQzo8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9U
WVBFX1NFVF9NQUNfRFNUOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXpl
b2Yoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9zZXRfbWFjKTs8YnI+DQorwqAgwqAgwqAgwqBjYXNl
IFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9JUFY0X1NSQzo8YnI+DQorwqAgwqAgwqAgwqBjYXNl
IFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9JUFY0X0RTVDo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gc2l6ZW9mKHN0cnVjdCBydGVfZmxvd19hY3Rpb25fc2V0X2lwdjQpOzxi
cj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX0lQVjZfU1JDOjxi
cj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX0lQVjZfRFNUOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93
X2FjdGlvbl9zZXRfaXB2Nik7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05f
VFlQRV9TRVRfVFBfU1JDOjxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZ
UEVfU0VUX1RQX0RTVDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gc2l6ZW9m
KHN0cnVjdCBydGVfZmxvd19hY3Rpb25fc2V0X3RwKTs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJU
RV9GTE9XX0FDVElPTl9UWVBFX0lOQ19UQ1BfQUNLOjxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRF
X0ZMT1dfQUNUSU9OX1RZUEVfREVDX1RDUF9BQ0s6PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVf
RkxPV19BQ1RJT05fVFlQRV9JTkNfVENQX1NFUTo8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9G
TE9XX0FDVElPTl9UWVBFX0RFQ19UQ1BfU0VROjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybiBzaXplb2YocnRlX2JlMzJfdCk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxP
V19BQ1RJT05fVFlQRV9TRVRfVFRMOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9zZXRfdHRsKTs8YnI+DQorwqAgwqAgwqAg
wqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9JUFY0X0RTQ1A6PGJyPg0KK8KgIMKgIMKg
IMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9TRVRfSVBWNl9EU0NQOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9zZXRf
ZHNjcCk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9NRVRFUjo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gc2l6ZW9mKHN0cnVjdCBydGVfZmxv
d19hY3Rpb25fbWV0ZXIpOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZ
UEVfUkFXX0VOQ0FQOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yo
c3RydWN0IGFjdGlvbl9yYXdfZW5jYXBfZGF0YSk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVf
RkxPV19BQ1RJT05fVFlQRV9SQVdfREVDQVA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0dXJuIHNpemVvZihzdHJ1Y3QgYWN0aW9uX3Jhd19kZWNhcF9kYXRhKTs8YnI+DQorwqAgwqAg
wqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX1ZYTEFOX0VOQ0FQOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl92eGxh
bl9lbmNhcCkgKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA1ICogc2l6
ZW9mKHN0cnVjdCBydGVfZmxvd19pdGVtKSArIHNpemVvZihzdHJ1Y3QgcnRlX2Zsb3dfaXRlbV9l
dGgpICs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2l6ZW9mKHN0cnVj
dCBydGVfZmxvd19pdGVtX2lwdjQpICsgc2l6ZW9mKHN0cnVjdCBydGVfZmxvd19pdGVtX3VkcCkg
Kzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzaXplb2Yoc3RydWN0IHJ0
ZV9mbG93X2l0ZW1fdnhsYW4pOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9O
X1RZUEVfTU9ESUZZX0ZJRUxEOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBz
aXplb2Yoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9tb2RpZnlfZmllbGQpOzxicj4NCivCoCDCoCDC
oCDCoC8qIFplcm8tY29uZiB0eXBlcyAqLzxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1df
QUNUSU9OX1RZUEVfRFJPUDo8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9U
WVBFX0ZMQUc6PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9ERUNf
VFRMOjxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfVlhMQU5fREVD
QVA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KK8KgIMKgIMKg
IMKgZGVmYXVsdDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQor
wqAgwqAgwqAgwqB9PGJyPg0KK308YnI+DQorPGJyPg0KK3ZvaWQ8YnI+DQorZmlsbF9hY3Rpb25z
X3RlbXBsYXRlKHN0cnVjdCBydGVfZmxvd19hY3Rpb24gKmFjdGlvbnMsIHN0cnVjdCBydGVfZmxv
d19hY3Rpb24gKm1hc2tzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVp
bnQ2NF90ICpmbG93X2FjdGlvbnMsIHN0cnVjdCBydGVfZmxvd19wb3J0X2F0dHIgKnBvcnRfYXR0
ciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBib29sICpuZWVkX3dpcmVf
b3JpZ190YWJsZSwgc2l6ZV90ICpjb25mX3NpemVzLCB1aW50MzJfdCAqbl9hY3Rpb25zX291dCk8
YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHVpbnQ4X3QgYWN0aW9uc19jb3VudGVyID0gMDs8YnI+
DQorwqAgwqAgwqAgwqB1aW50OF90IGksIGo7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCpuZWVk
X3dpcmVfb3JpZ190YWJsZSA9IGZhbHNlOzxicj4NCivCoCDCoCDCoCDCoG1lbXNldChwb3J0X2F0
dHIsIDAsIHNpemVvZigqcG9ydF9hdHRyKSk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIFN0
YXRpYyBjb25maWd1cmF0aW9ucyBmb3IgYWN0aW9ucyB0aGF0IG5lZWQgdGhlbSBpbiB0ZW1wbGF0
ZXMgKi88YnI+DQorwqAgwqAgwqAgwqBzdGF0aWMgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9tYXJr
IG1hcmtfY29uZiA9IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuaWQgPSAxLDxicj4N
CivCoCDCoCDCoCDCoH07PGJyPg0KK8KgIMKgIMKgIMKgc3RhdGljIHN0cnVjdCBydGVfZmxvd19h
Y3Rpb25fcXVldWUgcXVldWVfY29uZiA9IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAu
aW5kZXggPSAwLDxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0KK8KgIMKgIMKgIMKgc3RhdGljIHN0
cnVjdCBydGVfZmxvd19hY3Rpb25fcG9ydF9pZCBwb3J0X2lkX2NvbmYgPSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLmlkID0gMCw8YnI+DQorwqAgwqAgwqAgwqB9Ozxicj4NCivCoCDC
oCDCoCDCoHN0YXRpYyBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX2p1bXAganVtcF9jb25mID0gezxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ncm91cCA9IDEsPGJyPg0KK8KgIMKgIMKgIMKg
fTs8YnI+DQorwqAgwqAgwqAgwqBzdGF0aWMgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9tb2RpZnlf
ZmllbGQgc2V0X21ldGFfY29uZiA9IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAub3Bl
cmF0aW9uID0gUlRFX0ZMT1dfTU9ESUZZX1NFVCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAuZHN0ID0gey5maWVsZCA9IFJURV9GTE9XX0ZJRUxEX01FVEF9LDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoC5zcmMgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAuZmllbGQgPSBSVEVfRkxPV19GSUVMRF9WQUxVRSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAudmFsdWUgPSB7MCwgMCwgMCwgTUVUQV9EQVRB
fSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9LDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC53aWR0aCA9IDMyLDxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoC8qIFN0YXRpYyBtYXNrIGNvbmZpZ3VyYXRpb25zIGZvciBlYWNo
IGFjdGlvbiB0eXBlICovPGJyPg0KK8KgIMKgIMKgIMKgc3RhdGljIHN0cnVjdCBydGVfZmxvd19h
Y3Rpb25fbWFyayBtYXJrX21hc2sgPSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmlk
ID0gVUlOVDMyX01BWCw8YnI+DQorwqAgwqAgwqAgwqB9Ozxicj4NCivCoCDCoCDCoCDCoHN0YXRp
YyBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX3F1ZXVlIHF1ZXVlX21hc2sgPSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLmluZGV4ID0gVUlOVDE2X01BWCw8YnI+DQorwqAgwqAgwqAgwqB9
Ozxicj4NCivCoCDCoCDCoCDCoHN0YXRpYyBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX2p1bXAganVt
cF9tYXNrID0gezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ncm91cCA9IFVJTlQzMl9N
QVgsPGJyPg0KK8KgIMKgIMKgIMKgfTs8YnI+DQorwqAgwqAgwqAgwqBzdGF0aWMgc3RydWN0IHJ0
ZV9mbG93X2FjdGlvbl9yc3MgcnNzX21hc2sgPSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLmxldmVsID0gVUlOVDMyX01BWCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAudHlw
ZXMgPSBVSU5UNjRfTUFYLDxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0KK8KgIMKgIMKgIMKgc3Rh
dGljIHN0cnVjdCBydGVfZmxvd19hY3Rpb25fc2V0X21ldGEgc2V0X21ldGFfbWFzayA9IHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZGF0YSA9IFVJTlQzMl9NQVgsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLm1hc2sgPSBVSU5UMzJfTUFYLDxicj4NCivCoCDCoCDCoCDCoH07
PGJyPg0KK8KgIMKgIMKgIMKgc3RhdGljIHN0cnVjdCBydGVfZmxvd19hY3Rpb25fc2V0X3RhZyBz
ZXRfdGFnX21hc2sgPSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmRhdGEgPSBVSU5U
MzJfTUFYLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5tYXNrID0gVUlOVDMyX01BWCw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuaW5kZXggPSBVSU5UOF9NQVgsPGJyPg0KK8Kg
IMKgIMKgIMKgfTs8YnI+DQorwqAgwqAgwqAgwqBzdGF0aWMgc3RydWN0IHJ0ZV9mbG93X2FjdGlv
bl9wb3J0X2lkIHBvcnRfaWRfbWFzayA9IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAu
aWQgPSBVSU5UMzJfTUFYLDxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0KK8KgIMKgIMKgIMKgc3Rh
dGljIHN0cnVjdCBydGVfZmxvd19hY3Rpb25fY291bnQgY291bnRfbWFzazs8YnI+DQorwqAgwqAg
wqAgwqBzdGF0aWMgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9zZXRfbWFjIHNldF9tYWNfbWFzayA9
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubWFjX2FkZHIgPSB7MHhmZiwgMHhmZiwg
MHhmZiwgMHhmZiwgMHhmZiwgMHhmZn0sPGJyPg0KK8KgIMKgIMKgIMKgfTs8YnI+DQorwqAgwqAg
wqAgwqBzdGF0aWMgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9zZXRfaXB2NCBzZXRfaXB2NF9tYXNr
ID0gezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5pcHY0X2FkZHIgPSBVSU5UMzJfTUFY
LDxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0KK8KgIMKgIMKgIMKgc3RhdGljIHN0cnVjdCBydGVf
Zmxvd19hY3Rpb25fc2V0X2lwdjYgc2V0X2lwdjZfbWFzayA9IHs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAuaXB2Nl9hZGRyLmEgPSB7MHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwg
MHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweGZmLCAweGZmLCAweGZmLCAweGZmLCAw
eGZmfX07PGJyPg0KK8KgIMKgIMKgIMKgc3RhdGljIHN0cnVjdCBydGVfZmxvd19hY3Rpb25fc2V0
X3RwIHNldF90cF9tYXNrID0gezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5wb3J0ID0g
VUlOVDE2X01BWCw8YnI+DQorwqAgwqAgwqAgwqB9Ozxicj4NCivCoCDCoCDCoCDCoHN0YXRpYyBy
dGVfYmUzMl90IHRjcF9zZXFfYWNrX21hc2sgPSBVSU5UMzJfTUFYOzxicj4NCivCoCDCoCDCoCDC
oHN0YXRpYyBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX3NldF90dGwgc2V0X3R0bF9tYXNrID0gezxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC50dGxfdmFsdWUgPSBVSU5UOF9NQVgsPGJyPg0K
K8KgIMKgIMKgIMKgfTs8YnI+DQorwqAgwqAgwqAgwqBzdGF0aWMgc3RydWN0IHJ0ZV9mbG93X2Fj
dGlvbl9zZXRfZHNjcCBzZXRfZHNjcF9tYXNrID0gezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoC5kc2NwID0gVUlOVDhfTUFYLDxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0KK8KgIMKgIMKg
IMKgc3RhdGljIHN0cnVjdCBydGVfZmxvd19hY3Rpb25fbWV0ZXIgbWV0ZXJfbWFzayA9IHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubXRyX2lkID0gVUlOVDMyX01BWCw8YnI+DQorwqAg
wqAgwqAgwqB9Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBzdGF0aWMgY29uc3Qgc3RydWN0IHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50NjRfdCBmbG93X21hc2s7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZW51bSBydGVfZmxvd19hY3Rpb25fdHlwZSB0eXBlOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IHZvaWQgKmFjdGlvbl9jb25mOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IHZvaWQgKmFjdGlvbl9tYXNrOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IGJvb2wgbmVlZF93aXJlX29yaWdfdGFibGU7PGJyPg0K
K8KgIMKgIMKgIMKgfSB0ZW1wbGF0ZV9hY3Rpb25zW10gPSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKge0ZMT1dfQUNUSU9OX01BU0soUlRFX0ZMT1dfQUNUSU9OX1RZUEVfTUFSSyksIFJU
RV9GTE9XX0FDVElPTl9UWVBFX01BUkssICZhbXA7bWFya19jb25mLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmYW1wO21hcmtfbWFzaywgdHJ1ZX0sPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKge0ZMT1dfQUNUSU9OX01BU0soUlRFX0ZMT1dfQUNUSU9OX1RZUEVfQ09VTlQpLCBS
VEVfRkxPV19BQ1RJT05fVFlQRV9DT1VOVCwgTlVMTCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJmFtcDtjb3VudF9tYXNrLCBmYWxzZX0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKge0ZMT1dfQUNUSU9OX01BU0soUlRFX0ZMT1dfQUNUSU9OX1RZUEVfTU9ESUZZX0ZJRUxEKSw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfTU9ESUZZ
X0ZJRUxELCAmYW1wO3NldF9tZXRhX2NvbmYsICZhbXA7c2V0X21ldGFfbWFzaywgZmFsc2V9LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FD
VElPTl9UWVBFX1NFVF9UQUcpLCBSVEVfRkxPV19BQ1RJT05fVFlQRV9TRVRfVEFHLCBOVUxMLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO3NldF90YWdfbWFzaywgZmFsc2V9LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FD
VElPTl9UWVBFX0ZMQUcpLCBSVEVfRkxPV19BQ1RJT05fVFlQRV9GTEFHLCBOVUxMLCBOVUxMLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmYWxzZX0sPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKge0ZMT1dfQUNUSU9OX01BU0soUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX01BQ19T
UkMpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSVEVfRkxPV19BQ1RJT05fVFlQRV9T
RVRfTUFDX1NSQywgTlVMTCwgJmFtcDtzZXRfbWFjX21hc2ssIGZhbHNlfSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB7RkxPV19BQ1RJT05fTUFTSyhSVEVfRkxPV19BQ1RJT05fVFlQRV9T
RVRfTUFDX0RTVCksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJURV9GTE9XX0FDVElP
Tl9UWVBFX1NFVF9NQUNfRFNULCBOVUxMLCAmYW1wO3NldF9tYWNfbWFzaywgZmFsc2V9LDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FDVElP
Tl9UWVBFX1NFVF9JUFY0X1NSQyksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJURV9G
TE9XX0FDVElPTl9UWVBFX1NFVF9JUFY0X1NSQywgTlVMTCwgJmFtcDtzZXRfaXB2NF9tYXNrLCBm
YWxzZX0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKge0ZMT1dfQUNUSU9OX01BU0soUlRF
X0ZMT1dfQUNUSU9OX1RZUEVfU0VUX0lQVjRfRFNUKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX0lQVjRfRFNULCBOVUxMLCAmYW1wO3NldF9p
cHY0X21hc2ssIGZhbHNlfSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7RkxPV19BQ1RJ
T05fTUFTSyhSVEVfRkxPV19BQ1RJT05fVFlQRV9TRVRfSVBWNl9TUkMpLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBSVEVfRkxPV19BQ1RJT05fVFlQRV9TRVRfSVBWNl9TUkMsIE5VTEws
ICZhbXA7c2V0X2lwdjZfbWFzaywgZmFsc2V9LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9JUFY2X0RTVCksPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9JUFY2
X0RTVCwgTlVMTCwgJmFtcDtzZXRfaXB2Nl9tYXNrLCBmYWxzZX0sPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKge0ZMT1dfQUNUSU9OX01BU0soUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX1RQ
X1NSQyksIFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9UUF9TUkMsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIE5VTEwsICZhbXA7c2V0X3RwX21hc2ssIGZhbHNlfSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB7RkxPV19BQ1RJT05fTUFTSyhSVEVfRkxPV19BQ1RJT05fVFlQRV9T
RVRfVFBfRFNUKSwgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX1RQX0RTVCw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwgJmFtcDtzZXRfdHBfbWFzaywgZmFsc2V9LDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FDVElPTl9U
WVBFX0lOQ19UQ1BfQUNLKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUlRFX0ZMT1df
QUNUSU9OX1RZUEVfSU5DX1RDUF9BQ0ssIE5VTEwsICZhbXA7dGNwX3NlcV9hY2tfbWFzaywgZmFs
c2V9LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9G
TE9XX0FDVElPTl9UWVBFX0RFQ19UQ1BfQUNLKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfREVDX1RDUF9BQ0ssIE5VTEwsICZhbXA7dGNwX3NlcV9h
Y2tfbWFzaywgZmFsc2V9LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHtGTE9XX0FDVElP
Tl9NQVNLKFJURV9GTE9XX0FDVElPTl9UWVBFX0lOQ19UQ1BfU0VRKSw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfSU5DX1RDUF9TRVEsIE5VTEwsICZh
bXA7dGNwX3NlcV9hY2tfbWFzaywgZmFsc2V9LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FDVElPTl9UWVBFX0RFQ19UQ1BfU0VRKSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfREVDX1RDUF9T
RVEsIE5VTEwsICZhbXA7dGNwX3NlcV9hY2tfbWFzaywgZmFsc2V9LDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9U
VEwpLCBSVEVfRkxPV19BQ1RJT05fVFlQRV9TRVRfVFRMLCBOVUxMLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmYW1wO3NldF90dGxfbWFzaywgZmFsc2V9LDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FDVElPTl9UWVBFX0RFQ19U
VEwpLCBSVEVfRkxPV19BQ1RJT05fVFlQRV9ERUNfVFRMLCBOVUxMLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBOVUxMLCBmYWxzZX0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
e0ZMT1dfQUNUSU9OX01BU0soUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX0lQVjRfRFNDUCksPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9JUFY0
X0RTQ1AsIE5VTEwsICZhbXA7c2V0X2RzY3BfbWFzaywgZmFsc2V9LDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9J
UFY2X0RTQ1ApLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSVEVfRkxPV19BQ1RJT05f
VFlQRV9TRVRfSVBWNl9EU0NQLCBOVUxMLCAmYW1wO3NldF9kc2NwX21hc2ssIGZhbHNlfSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7RkxPV19BQ1RJT05fTUFTSyhSVEVfRkxPV19BQ1RJ
T05fVFlQRV9RVUVVRSksIFJURV9GTE9XX0FDVElPTl9UWVBFX1FVRVVFLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmYW1wO3F1ZXVlX2NvbmYsICZhbXA7cXVldWVfbWFzaywgdHJ1ZX0s
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKge0ZMT1dfQUNUSU9OX01BU0soUlRFX0ZMT1df
QUNUSU9OX1RZUEVfUlNTKSwgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfUlNTLCBOVUxMLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO3Jzc19tYXNrLCB0cnVlfSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB7RkxPV19BQ1RJT05fTUFTSyhSVEVfRkxPV19BQ1RJT05fVFlQRV9K
VU1QKSwgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfSlVNUCwgJmFtcDtqdW1wX2NvbmYsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7anVtcF9tYXNrLCBmYWxzZX0sPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKge0ZMT1dfQUNUSU9OX01BU0soUlRFX0ZMT1dfQUNUSU9OX1RZUEVf
UE9SVF9JRCksIFJURV9GTE9XX0FDVElPTl9UWVBFX1BPUlRfSUQsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZhbXA7cG9ydF9pZF9jb25mLCAmYW1wO3BvcnRfaWRfbWFzaywgZmFsc2V9
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHtGTE9XX0FDVElPTl9NQVNLKFJURV9GTE9X
X0FDVElPTl9UWVBFX0RST1ApLCBSVEVfRkxPV19BQ1RJT05fVFlQRV9EUk9QLCBOVUxMLCBOVUxM
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmYWxzZX0sPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKge0hBSVJQSU5fUVVFVUVfQUNUSU9OLCBSVEVfRkxPV19BQ1RJT05fVFlQRV9R
VUVVRSwgJmFtcDtxdWV1ZV9jb25mLCAmYW1wO3F1ZXVlX21hc2ssIGZhbHNlfSw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB7SEFJUlBJTl9SU1NfQUNUSU9OLCBSVEVfRkxPV19BQ1RJT05f
VFlQRV9SU1MsIE5VTEwsICZhbXA7cnNzX21hc2ssIGZhbHNlfSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB7RkxPV19BQ1RJT05fTUFTSyhSVEVfRkxPV19BQ1RJT05fVFlQRV9NRVRFUiks
IFJURV9GTE9XX0FDVElPTl9UWVBFX01FVEVSLCBOVUxMLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmYW1wO21ldGVyX21hc2ssIGZhbHNlfSw8YnI+DQorwqAgwqAgwqAgwqB9Ozxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqBmb3IgKGogPSAwOyBqICZsdDsgTUFYX0FDVElPTlNfTlVNOyBq
KyspIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZmxvd19hY3Rpb25zW2pdID09
IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IFJURV9ESU0odGVtcGxh
dGVfYWN0aW9ucyk7IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmICgoZmxvd19hY3Rpb25zW2pdICZhbXA7IHRlbXBsYXRlX2FjdGlvbnNbaV0uZmxvd19t
YXNrKSA9PSAwKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNvbnRpbnVlOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzd2l0Y2ggKHRlbXBsYXRlX2FjdGlvbnNbaV0udHlwZSkgezxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfQ09V
TlQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cG9ydF9hdHRyLSZndDtuYl9jb3VudGVycysrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfQUdFOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcnRfYXR0ci0mZ3Q7
bmJfYWdpbmdfb2JqZWN0cysrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfTUVURVI6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcG9ydF9hdHRyLSZndDtuYl9tZXRl
cnMrKzs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFJU
RV9GTE9XX0FDVElPTl9UWVBFX0NPTk5UUkFDSzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwb3J0X2F0dHItJmd0O25iX2Nvbm5fdHJhY2tzKys7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxP
V19BQ1RJT05fVFlQRV9RVU9UQTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwb3J0X2F0dHItJmd0O25iX3F1b3RhcysrOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZmF1bHQ6Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYWN0aW9uc1thY3Rpb25zX2NvdW50ZXJdLnR5cGUgPSB0ZW1wbGF0ZV9h
Y3Rpb25zW2ldLnR5cGU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
YWN0aW9uc1thY3Rpb25zX2NvdW50ZXJdLmNvbmYgPSB0ZW1wbGF0ZV9hY3Rpb25zW2ldLmFjdGlv
bl9jb25mOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2tzW2Fj
dGlvbnNfY291bnRlcl0udHlwZSA9IHRlbXBsYXRlX2FjdGlvbnNbaV0udHlwZTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXNrc1thY3Rpb25zX2NvdW50ZXJdLmNv
bmYgPSB0ZW1wbGF0ZV9hY3Rpb25zW2ldLmFjdGlvbl9tYXNrOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbmZfc2l6ZXNbYWN0aW9uc19jb3VudGVyXSA9IGFjdGlv
bl9jb25mX3NpemUodGVtcGxhdGVfYWN0aW9uc1tpXS50eXBlKTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqbmVlZF93aXJlX29yaWdfdGFibGUgfD0gdGVtcGxhdGVf
YWN0aW9uc1tpXS5uZWVkX3dpcmVfb3JpZ190YWJsZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBhY3Rpb25zX2NvdW50ZXIrKzs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBhY3Rpb25zW2FjdGlv
bnNfY291bnRlcl0udHlwZSA9IFJURV9GTE9XX0FDVElPTl9UWVBFX0VORDs8YnI+DQorwqAgwqAg
wqAgwqBtYXNrc1thY3Rpb25zX2NvdW50ZXJdLnR5cGUgPSBSVEVfRkxPV19BQ1RJT05fVFlQRV9F
TkQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIHRha2UgRU5EIGludG8gYWNjb3VudCAqLzxi
cj4NCivCoCDCoCDCoCDCoCpuX2FjdGlvbnNfb3V0ID0gYWN0aW9uc19jb3VudGVyICsgMTs8YnI+
DQorfTxicj4NCmRpZmYgLS1naXQgYS9hcHAvdGVzdC1mbG93LXBlcmYvYWN0aW9uc19nZW4uaCBi
L2FwcC90ZXN0LWZsb3ctcGVyZi9hY3Rpb25zX2dlbi5oPGJyPg0KaW5kZXggOWUxM2IxNjRmOS4u
M2FjMGZmZWQ1OSAxMDA2NDQ8YnI+DQotLS0gYS9hcHAvdGVzdC1mbG93LXBlcmYvYWN0aW9uc19n
ZW4uaDxicj4NCisrKyBiL2FwcC90ZXN0LWZsb3ctcGVyZi9hY3Rpb25zX2dlbi5oPGJyPg0KQEAg
LTE3LDkgKzE3LDQwIEBAPGJyPg0KwqAjZGVmaW5lIFJURV9WWExBTl9HUEVfVURQX1BPUlQgMjUw
PGJyPg0KwqAjZGVmaW5lIFJURV9HRU5FVkVfVURQX1BPUlQgNjA4MTxicj4NCjxicj4NCisvKiBD
b21wb3VuZCBhY3Rpb24gZGF0YSBzdHJ1Y3R1cmVzIChuZWVkZWQgYnkgYXN5bmNfZmxvdy5jIGZv
ciBzbG90IGluaXQpICovPGJyPg0KKzxicj4NCisvKiBTdG9yYWdlIGZvciBzdHJ1Y3QgcnRlX2Zs
b3dfYWN0aW9uX3Jhd19lbmNhcCBpbmNsdWRpbmcgZXh0ZXJuYWwgZGF0YS4gKi88YnI+DQorc3Ry
dWN0IGFjdGlvbl9yYXdfZW5jYXBfZGF0YSB7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9m
bG93X2FjdGlvbl9yYXdfZW5jYXAgY29uZjs8YnI+DQorwqAgwqAgwqAgwqB1aW50OF90IGRhdGFb
MTI4XTs8YnI+DQorwqAgwqAgwqAgwqB1aW50OF90IHByZXNlcnZlWzEyOF07PGJyPg0KK8KgIMKg
IMKgIMKgdWludDE2X3QgaWR4Ozxicj4NCit9Ozxicj4NCis8YnI+DQorLyogU3RvcmFnZSBmb3Ig
c3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9yYXdfZGVjYXAgaW5jbHVkaW5nIGV4dGVybmFsIGRhdGEu
ICovPGJyPg0KK3N0cnVjdCBhY3Rpb25fcmF3X2RlY2FwX2RhdGEgezxicj4NCivCoCDCoCDCoCDC
oHN0cnVjdCBydGVfZmxvd19hY3Rpb25fcmF3X2RlY2FwIGNvbmY7PGJyPg0KK8KgIMKgIMKgIMKg
dWludDhfdCBkYXRhWzEyOF07PGJyPg0KK8KgIMKgIMKgIMKgdWludDE2X3QgaWR4Ozxicj4NCit9
Ozxicj4NCis8YnI+DQorLyogU3RvcmFnZSBmb3Igc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9yc3Mg
aW5jbHVkaW5nIGV4dGVybmFsIGRhdGEuICovPGJyPg0KK3N0cnVjdCBhY3Rpb25fcnNzX2RhdGEg
ezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBydGVfZmxvd19hY3Rpb25fcnNzIGNvbmY7PGJyPg0K
K8KgIMKgIMKgIMKgdWludDhfdCBrZXlbNDBdOzxicj4NCivCoCDCoCDCoCDCoHVpbnQxNl90IHF1
ZXVlWzEyOF07PGJyPg0KK307PGJyPg0KKzxicj4NCsKgdm9pZCBmaWxsX2FjdGlvbnMoc3RydWN0
IHJ0ZV9mbG93X2FjdGlvbiAqYWN0aW9ucywgdWludDY0X3QgKmZsb3dfYWN0aW9ucyw8YnI+DQrC
oCDCoCDCoCDCoCB1aW50MzJfdCBjb3VudGVyLCB1aW50MTZfdCBuZXh0X3RhYmxlLCB1aW50MTZf
dCBoYWlycGlucSw8YnI+DQrCoCDCoCDCoCDCoCB1aW50NjRfdCBlbmNhcF9kYXRhLCB1aW50NjRf
dCBkZWNhcF9kYXRhLCB1aW50OF90IGNvcmVfaWR4LDxicj4NCsKgIMKgIMKgIMKgIGJvb2wgdW5p
cXVlX2RhdGEsIHVpbnQ4X3QgcnhfcXVldWVzX2NvdW50LCB1aW50MTZfdCBkc3RfcG9ydCk7PGJy
Pg0KPGJyPg0KKy8qIEZpbGwgYWN0aW9ucyB0ZW1wbGF0ZSBmb3IgYXN5bmMgZmxvdyBBUEkgKHR5
cGVzIG9ubHksIG5vIHZhbHVlcykuPGJyPg0KKyAqIElmIGNvbmZfc2l6ZXMgaXMgbm9uLU5VTEws
IHBvcHVsYXRlcyBwZXItYWN0aW9uIGNvbmYgc2l6ZXMgYW5kIG5fYWN0aW9uc19vdXQuPGJyPg0K
KyAqLzxicj4NCit2b2lkIGZpbGxfYWN0aW9uc190ZW1wbGF0ZShzdHJ1Y3QgcnRlX2Zsb3dfYWN0
aW9uICphY3Rpb25zLCBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uICptYXNrcyw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDY0X3QgKmZsb3dfYWN0aW9ucywg
c3RydWN0IHJ0ZV9mbG93X3BvcnRfYXR0ciAqcG9ydF9hdHRyLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBib29sICpuZWVkX3dpcmVfb3JpZ190YWJsZSwgc2l6
ZV90ICpjb25mX3NpemVzLCB1aW50MzJfdCAqbl9hY3Rpb25zX291dCk7PGJyPg0KKzxicj4NCsKg
I2VuZGlmIC8qIEZMT1dfUEVSRl9BQ1RJT05fR0VOICovPGJyPg0KZGlmZiAtLWdpdCBhL2FwcC90
ZXN0LWZsb3ctcGVyZi9hc3luY19mbG93LmMgYi9hcHAvdGVzdC1mbG93LXBlcmYvYXN5bmNfZmxv
dy5jPGJyPg0KbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+DQppbmRleCAwMDAwMDAwMDAwLi5hZTVh
OTIyODU2PGJyPg0KLS0tIC9kZXYvbnVsbDxicj4NCisrKyBiL2FwcC90ZXN0LWZsb3ctcGVyZi9h
c3luY19mbG93LmM8YnI+DQpAQCAtMCwwICsxLDc2MSBAQDxicj4NCisvKiBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogQlNELTMtQ2xhdXNlPGJyPg0KKyAqIENvcHlyaWdodCAyMDI2IE1heGltZSBQ
ZWltICZsdDs8YSBocmVmPSJtYWlsdG86bWF4aW1lLnBlaW1AZ21haWwuY29tIiB0YXJnZXQ9Il9i
bGFuayI+bWF4aW1lLnBlaW1AZ21haWwuY29tPC9hPiZndDs8YnI+DQorICo8YnI+DQorICogVGhp
cyBmaWxlIGNvbnRhaW5zIHRoZSBhc3luYyBmbG93IEFQSSBpbXBsZW1lbnRhdGlvbjxicj4NCisg
KiBmb3IgdGhlIGZsb3ctcGVyZiBhcHBsaWNhdGlvbi48YnI+DQorICovPGJyPg0KKzxicj4NCisj
aW5jbHVkZSAmbHQ7c3RkaW8uaCZndDs8YnI+DQorI2luY2x1ZGUgJmx0O3N0ZGxpYi5oJmd0Ozxi
cj4NCisjaW5jbHVkZSAmbHQ7c3RyaW5nLmgmZ3Q7PGJyPg0KKzxicj4NCisjaW5jbHVkZSAmbHQ7
cnRlX2JpdG9wcy5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7cnRlX2NvbW1vbi5oJmd0Ozxicj4N
CisjaW5jbHVkZSAmbHQ7cnRlX2V0aGRldi5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7cnRlX2Zs
b3cuaCZndDs8YnI+DQorI2luY2x1ZGUgJmx0O3J0ZV92eGxhbi5oJmd0Ozxicj4NCis8YnI+DQor
I2luY2x1ZGUgJnF1b3Q7YWN0aW9uc19nZW4uaCZxdW90Ozxicj4NCisjaW5jbHVkZSAmcXVvdDth
c3luY19mbG93LmgmcXVvdDs8YnI+DQorI2luY2x1ZGUgJnF1b3Q7Zmxvd19nZW4uaCZxdW90Ozxi
cj4NCisjaW5jbHVkZSAmcXVvdDtpdGVtc19nZW4uaCZxdW90Ozxicj4NCis8YnI+DQorLyogTWF4
IGl0ZXJhdGlvbnMgd2hlbiBkcmFpbmluZyBwZW5kaW5nIGFzeW5jIGNvbXBsZXRpb25zIGR1cmlu
ZyBjbGVhbnVwICovPGJyPg0KKyNkZWZpbmUgRFJBSU5fTUFYX0lURVJBVElPTlMgMTAwPGJyPg0K
Kzxicj4NCisvKiBQZXItcG9ydCBhc3luYyBmbG93IHJlc291cmNlcyAqLzxicj4NCitzdGF0aWMg
c3RydWN0IGFzeW5jX2Zsb3dfcmVzb3VyY2VzIHBvcnRfcmVzb3VyY2VzW01BWF9QT1JUU107PGJy
Pg0KKzxicj4NCisvKjxicj4NCisgKiBJbml0aWFsaXplIGNvbXBvdW5kIGFjdGlvbiB0eXBlcyB3
aXRoaW4gYSBwcmUtYWxsb2NhdGVkIHNsb3QuPGJyPg0KKyAqIENhbGxlZCBvbmNlIHBlciBzbG90
IGR1cmluZyBwb29sIGluaXQgdG8gc2V0IHVwIGludGVybmFsIHBvaW50ZXJzPGJyPg0KKyAqIGZv
ciBSU1MsIFJBV19FTkNBUCwgUkFXX0RFQ0FQIGFuZCBWWExBTl9FTkNBUCBhY3Rpb25zLjxicj4N
CisgKi88YnI+DQorc3RhdGljIHZvaWQ8YnI+DQoraW5pdF9zbG90X2NvbXBvdW5kX2FjdGlvbnMo
c3RydWN0IHJ0ZV9mbG93X2FjdGlvbiAqYWN0aW9ucywgdWludDMyX3Qgbl9hY3Rpb25zLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25zdCBzaXplX3QgKmFj
dGlvbl9jb25mX3NpemVzKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgaTs8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IG5fYWN0aW9uczsgaSsrKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGFjdGlvbl9jb25mX3NpemVzW2ldID09
IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRjaCAoYWN0aW9uc1tpXS50eXBl
KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQ
RV9SU1M6IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3Qg
YWN0aW9uX3Jzc19kYXRhICpyc3MgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoChzdHJ1Y3QgYWN0aW9uX3Jzc19kYXRhICopKHVpbnRwdHJfdClh
Y3Rpb25zW2ldLmNvbmY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cnNzLSZndDtjb25mLmZ1bmMgPSBSVEVfRVRIX0hBU0hfRlVOQ1RJT05fREVGQVVMVDs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByc3MtJmd0O2NvbmYubGV2ZWwgPSAw
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJzcy0mZ3Q7Y29uZi50
eXBlcyA9IEdFVF9SU1NfSEYoKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByc3MtJmd0O2NvbmYua2V5X2xlbiA9IHNpemVvZihyc3MtJmd0O2tleSk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnNzLSZndDtjb25mLmtleSA9IHJzcy0m
Z3Q7a2V5Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJzcy0mZ3Q7
Y29uZi5xdWV1ZSA9IHJzcy0mZ3Q7cXVldWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcnNzLSZndDtrZXlbMF0gPSAxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX1JBV19F
TkNBUDogezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBh
Y3Rpb25fcmF3X2VuY2FwX2RhdGEgKmVuY2FwID08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoc3RydWN0IGFjdGlvbl9yYXdfZW5jYXBfZGF0YSAq
KSh1aW50cHRyX3QpYWN0aW9uc1tpXS5jb25mOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGVuY2FwLSZndDtjb25mLmRhdGEgPSBlbmNhcC0mZ3Q7ZGF0YTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxP
V19BQ1RJT05fVFlQRV9SQVdfREVDQVA6IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzdHJ1Y3QgYWN0aW9uX3Jhd19kZWNhcF9kYXRhICpkZWNhcCA9PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0cnVjdCBhY3Rp
b25fcmF3X2RlY2FwX2RhdGEgKikodWludHB0cl90KWFjdGlvbnNbaV0uY29uZjs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWNhcC0mZ3Q7Y29uZi5kYXRhID0gZGVj
YXAtJmd0O2RhdGE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfVlhMQU5fRU5DQVA6IHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAqIExheW91dCB3aXRoaW4gdGhlIGNvbmYgYXJlYTo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKsKgIMKgc3RydWN0IHJ0ZV9mbG93
X2FjdGlvbl92eGxhbl9lbmNhcDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAqwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfaXRlbVs1XTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAqwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfaXRlbV9ldGg8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKsKgIMKgc3RydWN0IHJ0ZV9mbG93
X2l0ZW1faXB2NDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqwqAg
wqBzdHJ1Y3QgcnRlX2Zsb3dfaXRlbV91ZHA8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKsKgIMKgc3RydWN0IHJ0ZV9mbG93X2l0ZW1fdnhsYW48YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB1aW50OF90ICpiYXNlID0gKHVpbnQ4X3QgKikodWludHB0cl90KWFj
dGlvbnNbaV0uY29uZjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBz
dHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX3Z4bGFuX2VuY2FwICp2ZSA9PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0cnVjdCBydGVfZmxvd19hY3Rp
b25fdnhsYW5fZW5jYXAgKiliYXNlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHN0cnVjdCBydGVfZmxvd19pdGVtICppdGVtcyA9PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0cnVjdCBydGVfZmxvd19pdGVtPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICopKGJhc2UgKyBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl92eGxhbl9lbmNh
cCkpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ4X3QgKmRh
dGEgPSAodWludDhfdCAqKShpdGVtcyArIDUpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfaXRlbV9ldGggKml0ZW1fZXRoID0g
KHN0cnVjdCBydGVfZmxvd19pdGVtX2V0aCAqKWRhdGE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZGF0YSArPSBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2l0ZW1fZXRo
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zs
b3dfaXRlbV9pcHY0ICppdGVtX2lwdjQgPSAoc3RydWN0IHJ0ZV9mbG93X2l0ZW1faXB2NCAqKWRh
dGE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGF0YSArPSBzaXpl
b2Yoc3RydWN0IHJ0ZV9mbG93X2l0ZW1faXB2NCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X2l0ZW1fdWRwICppdGVtX3VkcCA9IChzdHJ1
Y3QgcnRlX2Zsb3dfaXRlbV91ZHAgKilkYXRhOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGRhdGEgKz0gc2l6ZW9mKHN0cnVjdCBydGVfZmxvd19pdGVtX3VkcCk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X2l0
ZW1fdnhsYW4gKml0ZW1fdnhsYW4gPSAoc3RydWN0IHJ0ZV9mbG93X2l0ZW1fdnhsYW4gKilkYXRh
Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1zZXQo
aXRlbV9ldGgsIDAsIHNpemVvZigqaXRlbV9ldGgpKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBtZW1zZXQoaXRlbV9pcHY0LCAwLCBzaXplb2YoKml0ZW1faXB2NCkp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1lbXNldChpdGVtX3Vk
cCwgMCwgc2l6ZW9mKCppdGVtX3VkcCkpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG1lbXNldChpdGVtX3Z4bGFuLCAwLCBzaXplb2YoKml0ZW1fdnhsYW4pKTs8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXRlbV9pcHY0LSZn
dDtoZHIuc3JjX2FkZHIgPSBSVEVfSVBWNCgxMjcsIDAsIDAsIDEpOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGl0ZW1faXB2NC0mZ3Q7aGRyLnZlcnNpb25faWhsID0g
UlRFX0lQVjRfVkhMX0RFRjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpdGVtX3VkcC0mZ3Q7aGRyLmRzdF9wb3J0ID0gUlRFX0JFMTYoUlRFX1ZYTEFOX0RFRkFVTFRf
UE9SVCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXRlbV92eGxh
bi0mZ3Q7aGRyLnZuaVsyXSA9IDE7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGl0ZW1zWzBdLnR5cGUgPSBSVEVfRkxPV19JVEVNX1RZUEVfRVRIOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGl0ZW1zWzBdLnNwZWMgPSBpdGVt
X2V0aDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpdGVtc1swXS5t
YXNrID0gaXRlbV9ldGg7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aXRlbXNbMV0udHlwZSA9IFJURV9GTE9XX0lURU1fVFlQRV9JUFY0Ozxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGl0ZW1zWzFdLnNwZWMgPSBpdGVtX2lwdjQ7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXRlbXNbMV0ubWFzayA9IGl0ZW1f
aXB2NDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpdGVtc1syXS50
eXBlID0gUlRFX0ZMT1dfSVRFTV9UWVBFX1VEUDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpdGVtc1syXS5zcGVjID0gaXRlbV91ZHA7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXRlbXNbMl0ubWFzayA9IGl0ZW1fdWRwOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGl0ZW1zWzNdLnR5cGUgPSBSVEVfRkxP
V19JVEVNX1RZUEVfVlhMQU47PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaXRlbXNbM10uc3BlYyA9IGl0ZW1fdnhsYW47PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaXRlbXNbM10ubWFzayA9IGl0ZW1fdnhsYW47PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXRlbXNbNF0udHlwZSA9IFJURV9GTE9XX0lURU1f
VFlQRV9FTkQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHZlLSZndDtkZWZpbml0aW9uID0gaXRlbXM7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4N
CivCoCDCoCDCoCDCoH08YnI+DQorfTxicj4NCis8YnI+DQorLyo8YnI+DQorICogQWxsb2NhdGUg
YW5kIHByZS1pbml0aWFsaXplIGFsbCBwZXItc2xvdCBmbGF0IGJ1ZmZlcnMuPGJyPg0KKyAqIFJl
dHVybnMgMCBvbiBzdWNjZXNzLjxicj4NCisgKi88YnI+DQorc3RhdGljIGludDxicj4NCitpbml0
X3Nsb3RfcG9vbChzdHJ1Y3QgYXN5bmNfZmxvd19yZXNvdXJjZXMgKnJlcywgdWludDMyX3QgbmJf
cXVldWVzLCB1aW50MzJfdCBxdWV1ZV9zaXplLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCBj
b25zdCBzdHJ1Y3QgcnRlX2Zsb3dfaXRlbSAqcGF0dGVybiwgdWludDMyX3Qgbl9pdGVtcywgY29u
c3Qgc2l6ZV90ICppdGVtX3NwZWNfc2l6ZXMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIGNv
bnN0IHN0cnVjdCBydGVfZmxvd19hY3Rpb24gKnRlbXBsYXRlX2FjdGlvbnMsIHVpbnQzMl90IG5f
YWN0aW9ucyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3Qgc2l6ZV90ICphY3Rpb25f
Y29uZl9zaXplcyk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IGl0ZW1zX2FycmF5
X2J5dGVzLCBhY3Rpb25zX2FycmF5X2J5dGVzOzxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IHNw
ZWNfZGF0YV9ieXRlcywgY29uZl9kYXRhX2J5dGVzLCBtYXNrX2RhdGFfYnl0ZXM7PGJyPg0KK8Kg
IMKgIMKgIMKgdWludDMyX3Qgc2xvdF9zaXplLCBudW1fc2xvdHM7PGJyPg0KK8KgIMKgIMKgIMKg
dWludDMyX3QgcywgaTs8YnI+DQorwqAgwqAgwqAgwqB1aW50OF90ICptcHRyOzxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqAvKiBDb21wdXRlIHNoYXJlZCBtYXNrIHNpemUgKi88YnI+DQorwqAgwqAg
wqAgwqBtYXNrX2RhdGFfYnl0ZXMgPSAwOzxicj4NCivCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkg
Jmx0OyBuX2l0ZW1zOyBpKyspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWFza19kYXRh
X2J5dGVzICs9IFJURV9BTElHTl9DRUlMKGl0ZW1fc3BlY19zaXplc1tpXSwgOCk7PGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoC8qIHNwZWNzIGFuZCBtYXNrcyBoYXZlIHRoZSBzYW1lIHNpemUgKi88
YnI+DQorwqAgwqAgwqAgwqBzcGVjX2RhdGFfYnl0ZXMgPSBtYXNrX2RhdGFfYnl0ZXM7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGNvbmZfZGF0YV9ieXRlcyA9IDA7PGJyPg0KK8KgIMKgIMKgIMKg
Zm9yIChpID0gMDsgaSAmbHQ7IG5fYWN0aW9uczsgaSsrKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNvbmZfZGF0YV9ieXRlcyArPSBSVEVfQUxJR05fQ0VJTChhY3Rpb25fY29uZl9zaXpl
c1tpXSwgOCk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIENvbXB1dGUgcGVyLXNsb3QgbGF5
b3V0IHNpemVzICgrIDEgZm9yIEVORCBzZW50aW5lbCkgKi88YnI+DQorwqAgwqAgwqAgwqBpdGVt
c19hcnJheV9ieXRlcyA9IG5faXRlbXMgKiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2l0ZW0pOzxi
cj4NCivCoCDCoCDCoCDCoGFjdGlvbnNfYXJyYXlfYnl0ZXMgPSBuX2FjdGlvbnMgKiBzaXplb2Yo
c3RydWN0IHJ0ZV9mbG93X2FjdGlvbik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHNsb3Rfc2l6
ZSA9IFJURV9BTElHTl9DRUlMKGl0ZW1zX2FycmF5X2J5dGVzICsgYWN0aW9uc19hcnJheV9ieXRl
cyArIHNwZWNfZGF0YV9ieXRlcyArPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbmZfZGF0YV9ieXRlcyw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUlRFX0NB
Q0hFX0xJTkVfU0laRSk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoG51bV9zbG90cyA9IHF1ZXVl
X3NpemUgKiBuYl9xdWV1ZXM7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIFN0b3JlIGxheW91
dCBpbmZvICovPGJyPg0KK8KgIMKgIMKgIMKgcmVzLSZndDtzbG90X3NpemUgPSBzbG90X3NpemU7
PGJyPg0KK8KgIMKgIMKgIMKgcmVzLSZndDtzbG90c19wZXJfcXVldWUgPSBxdWV1ZV9zaXplOzxi
cj4NCivCoCDCoCDCoCDCoHJlcy0mZ3Q7bmJfcXVldWVzID0gbmJfcXVldWVzOzxicj4NCivCoCDC
oCDCoCDCoHJlcy0mZ3Q7bl9pdGVtcyA9IG5faXRlbXM7PGJyPg0KK8KgIMKgIMKgIMKgcmVzLSZn
dDtuX2FjdGlvbnMgPSBuX2FjdGlvbnM7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIEFsbG9j
YXRlIHNoYXJlZCBtYXNrcyAqLzxicj4NCivCoCDCoCDCoCDCoGlmIChtYXNrX2RhdGFfYnl0ZXMg
Jmd0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzLSZndDtzaGFyZWRfbWFz
a3MgPSBhbGlnbmVkX2FsbG9jKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFJURV9DQUNIRV9MSU5FX1NJWkUsIFJURV9BTElHTl9DRUlMKG1hc2tfZGF0YV9ieXRlcywg
UlRFX0NBQ0hFX0xJTkVfU0laRSkpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChy
ZXMtJmd0O3NoYXJlZF9tYXNrcyA9PSBOVUxMKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O0ZhaWxlZCB0byBhbGxvY2F0ZSBz
aGFyZWQgbWFza3MgKCV1IGJ5dGVzKVxuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2tfZGF0YV9ieXRlcyk7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FTk9NRU07PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1lbXNldChy
ZXMtJmd0O3NoYXJlZF9tYXNrcywgMCwgbWFza19kYXRhX2J5dGVzKTs8YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogQ29weSBtYXNrIGRhdGEgZnJvbSB0ZW1wbGF0ZSBwYXR0
ZXJuICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbXB0ciA9IHJlcy0mZ3Q7c2hhcmVk
X21hc2tzOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBu
X2l0ZW1zOyBpKyspIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAoaXRlbV9zcGVjX3NpemVzW2ldICZndDsgMCAmYW1wOyZhbXA7IHBhdHRlcm5baV0ubWFzayAh
PSBOVUxMKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoG1lbWNweShtcHRyLCBwYXR0ZXJuW2ldLm1hc2ssIGl0ZW1fc3BlY19zaXplc1tpXSk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbXB0ciArPSBSVEVfQUxJR05f
Q0VJTChpdGVtX3NwZWNfc2l6ZXNbaV0sIDgpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oH08YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIEFsbG9jYXRl
IHBlci1zbG90IHBvb2wgKi88YnI+DQorwqAgwqAgwqAgwqAvKiBzbG90X3NpemUgaXMgYWxyZWFk
eSBjYWNoZS1saW5lIGFsaWduZWQsIHNvIHRvdGFsIGlzIGEgbXVsdGlwbGUgKi88YnI+DQorwqAg
wqAgwqAgwqByZXMtJmd0O3Nsb3RfcG9vbCA9IGFsaWduZWRfYWxsb2MoUlRFX0NBQ0hFX0xJTkVf
U0laRSwgKHNpemVfdCludW1fc2xvdHMgKiBzbG90X3NpemUpOzxicj4NCivCoCDCoCDCoCDCoGlm
IChyZXMtJmd0O3Nsb3RfcG9vbCA9PSBOVUxMKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZnByaW50ZihzdGRlcnIsICZxdW90O0ZhaWxlZCB0byBhbGxvY2F0ZSBzbG90IHBvb2wgKCV1
IHNsb3RzICogJXUgYnl0ZXMpXG4mcXVvdDssIG51bV9zbG90cyw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzbG90X3NpemUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGZyZWUocmVzLSZndDtzaGFyZWRfbWFza3MpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJlcy0mZ3Q7c2hhcmVkX21hc2tzID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gLUVOT01FTTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKg
IMKgbWVtc2V0KHJlcy0mZ3Q7c2xvdF9wb29sLCAwLCAoc2l6ZV90KW51bV9zbG90cyAqIHNsb3Rf
c2l6ZSk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIFByZS1pbml0aWFsaXplIGV2ZXJ5IHNs
b3QgKi88YnI+DQorwqAgwqAgwqAgwqBmb3IgKHMgPSAwOyBzICZsdDsgbnVtX3Nsb3RzOyBzKysp
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50OF90ICpzbG90ID0gcmVzLSZndDtz
bG90X3Bvb2wgKyAoc2l6ZV90KXMgKiBzbG90X3NpemU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc3RydWN0IHJ0ZV9mbG93X2l0ZW0gKml0ZW1zID0gKHN0cnVjdCBydGVfZmxvd19pdGVt
ICopc2xvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfYWN0
aW9uICphY3Rpb25zID08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAo
c3RydWN0IHJ0ZV9mbG93X2FjdGlvbiAqKShzbG90ICsgaXRlbXNfYXJyYXlfYnl0ZXMpOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ4X3QgKmRhdGEgPSBzbG90ICsgaXRlbXNfYXJy
YXlfYnl0ZXMgKyBhY3Rpb25zX2FycmF5X2J5dGVzOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAvKiBQcmUtc2V0IGl0ZW1zOiBzcGVjIOKGkiBwZXItc2xvdCBkYXRhLCBtYXNr
IOKGkiBzaGFyZWQgbWFza3MgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtcHRyID0g
cmVzLSZndDtzaGFyZWRfbWFza3M7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChp
ID0gMDsgaSAmbHQ7IG5faXRlbXM7IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGl0ZW1zW2ldLnR5cGUgPSBwYXR0ZXJuW2ldLnR5cGU7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGl0ZW1fc3BlY19zaXplc1tpXSAmZ3Q7
IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpdGVtc1tpXS5zcGVjID0gZGF0YTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpdGVtc1tpXS5tYXNrID0gbXB0cjs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkYXRhICs9IFJURV9BTElHTl9D
RUlMKGl0ZW1fc3BlY19zaXplc1tpXSwgOCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbXB0ciArPSBSVEVfQUxJR05fQ0VJTChpdGVtX3NwZWNf
c2l6ZXNbaV0sIDgpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaXRlbXNbbl9pdGVtc10udHlwZSA9IFJURV9GTE9XX0lURU1fVFlQRV9FTkQ7PGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIFByZS1zZXQgYWN0aW9uczogY29uZiDihpIg
cGVyLXNsb3QgZGF0YSAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaSA9IDA7
IGkgJmx0OyBuX2FjdGlvbnM7IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGFjdGlvbnNbaV0udHlwZSA9IHRlbXBsYXRlX2FjdGlvbnNbaV0udHlwZTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoYWN0aW9uX2NvbmZfc2l6
ZXNbaV0gJmd0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYWN0aW9uc1tpXS5jb25mID0gZGF0YTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkYXRhICs9IFJURV9BTElHTl9DRUlMKGFj
dGlvbl9jb25mX3NpemVzW2ldLCA4KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGFjdGlvbnNbbl9hY3Rpb25zXS50eXBlID0gUlRFX0ZMT1dfQUNUSU9OX1RZ
UEVfRU5EOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBJbml0aWFsaXpl
IGNvbXBvdW5kIGFjdGlvbiB0eXBlcyAoUlNTLCBSQVdfRU5DQVAsIGV0Yy4pICovPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaW5pdF9zbG90X2NvbXBvdW5kX2FjdGlvbnMoYWN0aW9ucywg
bl9hY3Rpb25zLCBhY3Rpb25fY29uZl9zaXplcyk7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAvKiBBbGxvY2F0ZSBhbmQgaW5pdGlhbGl6ZSBwZXItcXVldWUgc2xv
dCB0cmFja2luZyAqLzxicj4NCivCoCDCoCDCoCDCoHJlcy0mZ3Q7cXVldWVzID0gYWxpZ25lZF9h
bGxvYyg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBSVEVfQ0FDSEVfTElORV9TSVpFLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9BTElHTl9DRUlMKG5iX3F1ZXVlcyAqIHNp
emVvZihzdHJ1Y3QgYXN5bmNfZmxvd19xdWV1ZSksIFJURV9DQUNIRV9MSU5FX1NJWkUpKTs8YnI+
DQorwqAgwqAgwqAgwqBpZiAocmVzLSZndDtxdWV1ZXMgPT0gTlVMTCkgezxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDtGYWlsZWQgdG8gYWxsb2NhdGUg
cXVldWUgc3RydWN0cyAoJXUgcXVldWVzKVxuJnF1b3Q7LCBuYl9xdWV1ZXMpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUocmVzLSZndDtzbG90X3Bvb2wpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJlcy0mZ3Q7c2xvdF9wb29sID0gTlVMTDs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBmcmVlKHJlcy0mZ3Q7c2hhcmVkX21hc2tzKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXMtJmd0O3NoYXJlZF9tYXNrcyA9IE5VTEw7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FTk9NRU07PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoG1lbXNldChyZXMtJmd0O3F1ZXVlcywgMCwgbmJfcXVldWVzICogc2l6ZW9mKHN0
cnVjdCBhc3luY19mbG93X3F1ZXVlKSk7PGJyPg0KK8KgIMKgIMKgIMKgZm9yIChzID0gMDsgcyAm
bHQ7IG5iX3F1ZXVlczsgcysrKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzLSZn
dDtxdWV1ZXNbc10uc2xvdHMgPSByZXMtJmd0O3Nsb3RfcG9vbCArIChzaXplX3QpcyAqIHF1ZXVl
X3NpemUgKiBzbG90X3NpemU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzLSZndDtx
dWV1ZXNbc10uaGVhZCA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBwcmludGYoJnF1b3Q7OjogU2xvdCBwb29sOiAldSBzbG90cyAqICV1IGJ5dGVzID0gJXUg
S0IgKHNoYXJlZCBtYXNrczogJXUgYnl0ZXMpXG4mcXVvdDssIG51bV9zbG90cyw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc2xvdF9zaXplLCAobnVtX3Nsb3RzICogc2xvdF9zaXplKSAvIDEw
MjQsIG1hc2tfZGF0YV9ieXRlcyk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiAwOzxi
cj4NCit9PGJyPg0KKzxicj4NCisvKjxicj4NCisgKiBIb3QtcGF0aDogdXBkYXRlIHBlci1mbG93
IGl0ZW0gdmFsdWVzIHRocm91Z2ggcHJlLXNldCBwb2ludGVycy48YnI+DQorICogT25seSBJUFY0
L0lQVjYgc3JjX2FkZHIgdmFyaWVzIHBlciBmbG93IChiYXNlZCBvbiBjb3VudGVyKS48YnI+DQor
ICovPGJyPg0KK3N0YXRpYyB2b2lkPGJyPg0KK3VwZGF0ZV9pdGVtX3ZhbHVlcyhzdHJ1Y3QgcnRl
X2Zsb3dfaXRlbSAqaXRlbXMsIHVpbnQzMl90IGNvdW50ZXIpPGJyPg0KK3s8YnI+DQorwqAgwqAg
wqAgwqB1aW50OF90IGk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGl0ZW1z
W2ldLnR5cGUgIT0gUlRFX0ZMT1dfSVRFTV9UWVBFX0VORDsgaSsrKSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3dpdGNoIChpdGVtc1tpXS50eXBlKSB7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19JVEVNX1RZUEVfSVBWNDo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoKHN0cnVjdCBydGVfZmxvd19pdGVtX2lwdjQgKiko
dWludHB0cl90KWl0ZW1zW2ldLnNwZWMpLSZndDtoZHIuc3JjX2FkZHIgPTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9CRTMyKGNvdW50ZXIp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfSVRFTV9UWVBFX0lQVjY6IHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfaXRl
bV9pcHY2ICpzcGVjID08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAoc3RydWN0IHJ0ZV9mbG93X2l0ZW1faXB2NiAqKSh1aW50cHRyX3QpaXRlbXNb
aV0uc3BlYzs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50OF90
IGo7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChqID0gMDsg
aiAmbHQ7IDQ7IGorKyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzcGVjLSZndDtoZHIuc3JjX2FkZHIuYVsxNSAtIGpdID0gY291bnRlciAmZ3Q7
Jmd0OyAoaiAqIDgpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJy
ZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9
PGJyPg0KK308YnI+DQorPGJyPg0KKy8qPGJyPg0KKyAqIEhvdC1wYXRoOiB1cGRhdGUgcGVyLWZs
b3cgYWN0aW9uIHZhbHVlcyB0aHJvdWdoIHByZS1zZXQgcG9pbnRlcnMuPGJyPg0KKyAqLzxicj4N
CitzdGF0aWMgdm9pZDxicj4NCit1cGRhdGVfYWN0aW9uX3ZhbHVlcyhzdHJ1Y3QgcnRlX2Zsb3df
YWN0aW9uICphY3Rpb25zLCB1aW50MzJfdCBjb3VudGVyLCB1aW50MTZfdCBoYWlycGlucSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDY0X3QgZW5jYXBfZGF0YSwgdWlu
dDY0X3QgZGVjYXBfZGF0YSwgX19ydGVfdW51c2VkIHVpbnQ4X3QgY29yZV9pZHgsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJvb2wgdW5pcXVlX2RhdGEsIHVpbnQ4X3Qgcnhf
cXVldWVzX2NvdW50LCB1aW50MTZfdCBkc3RfcG9ydCk8YnI+DQorezxicj4NCivCoCDCoCDCoCDC
oHVpbnQ4X3QgaTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgZm9yIChpID0gMDsgYWN0aW9uc1tp
XS50eXBlICE9IFJURV9GTE9XX0FDVElPTl9UWVBFX0VORDsgaSsrKSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3dpdGNoIChhY3Rpb25zW2ldLnR5cGUpIHs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX01BUks6PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKChzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX21h
cmsgKikodWludHB0cl90KWFjdGlvbnNbaV0uY29uZiktJmd0O2lkID08YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoY291bnRlciAlIDI1NSkgKyAx
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfUVVFVUU6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKChzdHJ1Y3QgcnRlX2Zsb3df
YWN0aW9uX3F1ZXVlICopKHVpbnRwdHJfdClhY3Rpb25zW2ldLmNvbmYpLSZndDtpbmRleCA9PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaGFpcnBp
bnEgPyAoY291bnRlciAlIGhhaXJwaW5xKSArIHJ4X3F1ZXVlc19jb3VudCA6PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGNvdW50ZXIgJSByeF9xdWV1ZXNfY291bnQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVf
RkxPV19BQ1RJT05fVFlQRV9NRVRFUjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAoKHN0cnVjdCBydGVfZmxvd19hY3Rpb25fbWV0ZXIgKikodWludHB0cl90KWFjdGlv
bnNbaV0uY29uZiktJmd0O210cl9pZCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY291bnRlcjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFJU
RV9GTE9XX0FDVElPTl9UWVBFX1JTUzogezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHN0cnVjdCBhY3Rpb25fcnNzX2RhdGEgKnJzcyA9PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0cnVjdCBhY3Rpb25fcnNzX2Rh
dGEgKikodWludHB0cl90KWFjdGlvbnNbaV0uY29uZjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB1aW50MTZfdCBxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChoYWlycGlucSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJzcy0mZ3Q7Y29uZi5xdWV1ZV9udW0gPSBoYWlycGlu
cTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBm
b3IgKHEgPSAwOyBxICZsdDsgaGFpcnBpbnE7IHErKyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByc3MtJmd0O3F1ZXVlW3Fd
ID0gcSArIHJ4X3F1ZXVlc19jb3VudDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9IGVsc2Ugezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJzcy0mZ3Q7Y29uZi5xdWV1ZV9udW0gPSByeF9xdWV1ZXNfY291bnQ7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChx
ID0gMDsgcSAmbHQ7IHJ4X3F1ZXVlc19jb3VudDsgcSsrKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJzcy0mZ3Q7cXVldWVb
cV0gPSBxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxP
V19BQ1RJT05fVFlQRV9TRVRfTUFDX1NSQzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
YXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9NQUNfRFNUOiB7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9zZXRfbWFjICpt
YWMgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oChzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX3NldF9tYWMgKikodWludHB0cl90KWFjdGlvbnNbaV0u
Y29uZjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50MzJfdCB2
YWwgPSB1bmlxdWVfZGF0YSA/IGNvdW50ZXIgOiAxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHVpbnQ4X3Qgajs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBmb3IgKGogPSAwOyBqICZsdDsgUlRFX0VUSEVSX0FERFJfTEVOOyBqKyspIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYWMt
Jmd0O21hY19hZGRyW2pdID0gdmFsICZhbXA7IDB4ZmY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFsICZndDsmZ3Q7PSA4Ozxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9TRVRf
SVBWNF9TUkM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJ
T05fVFlQRV9TRVRfSVBWNF9EU1Q6IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB1aW50MzJfdCBpcCA9IHVuaXF1ZV9kYXRhID8gY291bnRlciA6IDE7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKChzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9u
X3NldF9pcHY0ICopKHVpbnRwdHJfdClhY3Rpb25zW2ldLmNvbmYpLSZndDtpcHY0X2FkZHIgPTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9C
RTMyKGlwICsgMSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX0lQVjZfU1JDOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX0lQVjZfRFNU
OiB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHJ0ZV9m
bG93X2FjdGlvbl9zZXRfaXB2NiAqdjYgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoChzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX3NldF9pcHY2ICop
KHVpbnRwdHJfdClhY3Rpb25zW2ldLmNvbmY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdWludDMyX3QgdmFsID0gdW5pcXVlX2RhdGEgPyBjb3VudGVyIDogMTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50OF90IGo7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChqID0gMDsgaiAmbHQ7IDE2OyBq
KyspIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB2Ni0mZ3Q7aXB2Nl9hZGRyLmFbal0gPSB2YWwgJmFtcDsgMHhmZjs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwgJmd0OyZndDs9IDg7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9U
WVBFX1NFVF9UUF9TUkM6IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB1aW50MzJfdCB0cCA9IHVuaXF1ZV9kYXRhID8gY291bnRlciA6IDEwMDs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0cCA9IHRwICUgMHhmZmZmOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCgoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9z
ZXRfdHAgKikodWludHB0cl90KWFjdGlvbnNbaV0uY29uZiktJmd0O3BvcnQgPTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9CRTE2KHRwICZh
bXA7IDB4ZmZmZik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfU0VUX1RQX0RTVDogezxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQzMl90IHRwID0gdW5pcXVlX2RhdGEg
PyBjb3VudGVyIDogMTAwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmICh0cCAmZ3Q7IDB4ZmZmZik8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB0cCAmZ3Q7Jmd0Oz0gMTY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgKChzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uX3NldF90cCAqKSh1aW50
cHRyX3QpYWN0aW9uc1tpXS5jb25mKS0mZ3Q7cG9ydCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUlRFX0JFMTYodHAgJmFtcDsgMHhmZmZmKTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBS
VEVfRkxPV19BQ1RJT05fVFlQRV9JTkNfVENQX0FDSzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX0RFQ19UQ1BfQUNLOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfSU5DX1RDUF9TRVE6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9ERUNf
VENQX1NFUTogezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQz
Ml90IHZhbCA9IHVuaXF1ZV9kYXRhID8gY291bnRlciA6IDE7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgKihydGVfYmUzMl90ICopKHVpbnRwdHJfdClhY3Rpb25zW2ld
LmNvbmYgPSBSVEVfQkUzMih2YWwpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0FDVElPTl9UWVBFX1NFVF9UVEw6IHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50MzJfdCB2YWwgPSB1bmlx
dWVfZGF0YSA/IGNvdW50ZXIgOiAxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCgoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9zZXRfdHRsICopKHVpbnRwdHJfdClhY3Rp
b25zW2ldLmNvbmYpLSZndDt0dGxfdmFsdWUgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZhbCAlIDB4ZmY7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVf
U0VUX0lQVjRfRFNDUDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9X
X0FDVElPTl9UWVBFX1NFVF9JUFY2X0RTQ1A6IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB1aW50MzJfdCB2YWwgPSB1bmlxdWVfZGF0YSA/IGNvdW50ZXIgOiAxOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCgoc3RydWN0IHJ0ZV9mbG93
X2FjdGlvbl9zZXRfZHNjcCAqKSh1aW50cHRyX3QpYWN0aW9uc1tpXS5jb25mKS0mZ3Q7ZHNjcCA9
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFs
ICUgMHhmZjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9QT1JUX0lEOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCgoc3RydWN0IHJ0ZV9mbG93X2FjdGlvbl9wb3J0X2lkICop
KHVpbnRwdHJfdClhY3Rpb25zW2ldLmNvbmYpLSZndDtpZCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZHN0X3BvcnQ7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY2FzZSBSVEVfRkxPV19BQ1RJT05fVFlQRV9SQVdfRU5DQVA6IHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgYWN0aW9uX3Jhd19lbmNhcF9kYXRh
ICplbmNhcCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKHN0cnVjdCBhY3Rpb25fcmF3X2VuY2FwX2RhdGEgKikodWludHB0cl90KWFjdGlvbnNb
aV0uY29uZjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50OF90
ICpoZWFkZXIgPSBlbmNhcC0mZ3Q7ZGF0YTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2V0aGVyX2hkciBldGhfaGRyOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBydGVfaXB2NF9oZHIgaXB2NF9oZHI7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHJ0ZV91ZHBfaGRy
IHVkcF9oZHI7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oG1lbXNldCgmYW1wO2V0aF9oZHIsIDAsIHNpemVvZihldGhfaGRyKSk7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGVuY2FwX2RhdGEgJmFtcDsgRkxPV19JVEVN
X01BU0soUlRFX0ZMT1dfSVRFTV9UWVBFX0VUSCkpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZW5jYXBfZGF0YSAmYW1wOyBGTE9XX0lU
RU1fTUFTSyhSVEVfRkxPV19JVEVNX1RZUEVfVkxBTikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXRoX2hkci5ldGhlcl90
eXBlID0gUlRFX0JFMTYoUlRFX0VUSEVSX1RZUEVfVkxBTik7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZSBpZiAoZW5jYXBfZGF0YSAmYW1w
OyBGTE9XX0lURU1fTUFTSyhSVEVfRkxPV19JVEVNX1RZUEVfSVBWNCkpPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXRoX2hk
ci5ldGhlcl90eXBlID0gUlRFX0JFMTYoUlRFX0VUSEVSX1RZUEVfSVBWNCk7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZSBpZiAoZW5jYXBf
ZGF0YSAmYW1wOyBGTE9XX0lURU1fTUFTSyhSVEVfRkxPV19JVEVNX1RZUEVfSVBWNikpPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZXRoX2hkci5ldGhlcl90eXBlID0gUlRFX0JFMTYoUlRFX0VUSEVSX1RZUEVfSVBWNik7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWVtY3B5
KGhlYWRlciwgJmFtcDtldGhfaGRyLCBzaXplb2YoZXRoX2hkcikpOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGhlYWRlciArPSBzaXplb2YoZXRo
X2hkcik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChlbmNhcF9kYXRhICZhbXA7IEZM
T1dfSVRFTV9NQVNLKFJURV9GTE9XX0lURU1fVFlQRV9JUFY0KSkgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQzMl90IGlwX2RzdCA9IHVu
aXF1ZV9kYXRhID8gY291bnRlciA6IDE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgbWVtc2V0KCZhbXA7aXB2NF9oZHIsIDAsIHNpemVvZihpcHY0
X2hkcikpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlwdjRfaGRyLnNyY19hZGRyID0gUlRFX0lQVjQoMTI3LCAwLCAwLCAxKTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpcHY0X2hkci5kc3Rf
YWRkciA9IFJURV9CRTMyKGlwX2RzdCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaXB2NF9oZHIudmVyc2lvbl9paGwgPSBSVEVfSVBWNF9WSExf
REVGOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChlbmNhcF9kYXRhICZhbXA7IEZMT1dfSVRFTV9NQVNLKFJURV9GTE9XX0lURU1fVFlQRV9V
RFApKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlwdjRfaGRyLm5leHRfcHJvdG9faWQgPSAxNzsgLyogVURQICovPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGVuY2Fw
X2RhdGEgJmFtcDsgRkxPV19JVEVNX01BU0soUlRFX0ZMT1dfSVRFTV9UWVBFX0dSRSkpPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaXB2NF9oZHIubmV4dF9wcm90b19pZCA9IDQ3OyAvKiBHUkUgKi88YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1jcHkoaGVhZGVyLCAmYW1w
O2lwdjRfaGRyLCBzaXplb2YoaXB2NF9oZHIpKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBoZWFkZXIgKz0gc2l6ZW9mKGlwdjRfaGRyKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGVuY2FwX2RhdGEgJmFtcDsgRkxPV19JVEVNX01B
U0soUlRFX0ZMT1dfSVRFTV9UWVBFX1VEUCkpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1zZXQoJmFtcDt1ZHBfaGRyLCAwLCBzaXplb2Yo
dWRwX2hkcikpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmIChlbmNhcF9kYXRhICZhbXA7IEZMT1dfSVRFTV9NQVNLKFJURV9GTE9XX0lURU1f
VFlQRV9WWExBTikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdWRwX2hkci5kc3RfcG9ydCA9IFJURV9CRTE2KFJURV9WWExB
Tl9ERUZBVUxUX1BPUlQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoG1lbWNweShoZWFkZXIsICZhbXA7dWRwX2hkciwgc2l6ZW9mKHVkcF9oZHIp
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBo
ZWFkZXIgKz0gc2l6ZW9mKHVkcF9oZHIpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbmNh
cC0mZ3Q7Y29uZi5zaXplID0gaGVhZGVyIC0gZW5jYXAtJmd0O2RhdGE7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9O
X1RZUEVfUkFXX0RFQ0FQOiB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3RydWN0IGFjdGlvbl9yYXdfZGVjYXBfZGF0YSAqZGVjYXBfZCA9PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHN0cnVjdCBhY3Rpb25fcmF3
X2RlY2FwX2RhdGEgKikodWludHB0cl90KWFjdGlvbnNbaV0uY29uZjs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50OF90ICpoZWFkZXIgPSBkZWNhcF9kLSZndDtk
YXRhOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBydGVf
ZXRoZXJfaGRyIGV0aF9oZHI7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG1lbXNldCgmYW1wO2V0aF9oZHIsIDAsIHNpemVvZihldGhfaGRyKSk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGRlY2FwX2RhdGEgJmFtcDsg
RkxPV19JVEVNX01BU0soUlRFX0ZMT1dfSVRFTV9UWVBFX0VUSCkpIHs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZGVjYXBfZGF0YSAmYW1w
OyBGTE9XX0lURU1fTUFTSyhSVEVfRkxPV19JVEVNX1RZUEVfSVBWNCkpPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXRoX2hk
ci5ldGhlcl90eXBlID0gUlRFX0JFMTYoUlRFX0VUSEVSX1RZUEVfSVBWNCk7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZSBpZiAoZGVjYXBf
ZGF0YSAmYW1wOyBGTE9XX0lURU1fTUFTSyhSVEVfRkxPV19JVEVNX1RZUEVfSVBWNikpPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZXRoX2hkci5ldGhlcl90eXBlID0gUlRFX0JFMTYoUlRFX0VUSEVSX1RZUEVfSVBWNik7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWVtY3B5
KGhlYWRlciwgJmFtcDtldGhfaGRyLCBzaXplb2YoZXRoX2hkcikpOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGhlYWRlciArPSBzaXplb2YoZXRo
X2hkcik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlY2FwX2QtJmd0O2NvbmYuc2l6ZSA9
IGhlYWRlciAtIGRlY2FwX2QtJmd0O2RhdGE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfQUNUSU9OX1RZUEVfVlhMQU5fRU5D
QVA6IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50OF90ICpi
YXNlID0gKHVpbnQ4X3QgKikodWludHB0cl90KWFjdGlvbnNbaV0uY29uZjs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfaXRlbSAqdml0ZW1z
ID08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAo
c3RydWN0IHJ0ZV9mbG93X2l0ZW08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKikoYmFzZSArIHNpemVvZihzdHJ1Y3QgcnRl
X2Zsb3dfYWN0aW9uX3Z4bGFuX2VuY2FwKSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdWludDMyX3QgaXBfZHN0ID0gdW5pcXVlX2RhdGEgPyBjb3VudGVyIDogMTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiB2aXRlbXNbMV0gaXMg
SVBWNCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCgoc3RydWN0
IHJ0ZV9mbG93X2l0ZW1faXB2NCAqKSh1aW50cHRyX3Qpdml0ZW1zWzFdLnNwZWMpLSZndDtoZHIu
ZHN0X2FkZHIgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFJURV9CRTMyKGlwX2RzdCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoH08YnI+DQorfTxicj4NCis8YnI+DQoraW50PGJyPg0KK2FzeW5jX2Zsb3dfaW5p
dF9wb3J0KHVpbnQxNl90IHBvcnRfaWQsIHVpbnQzMl90IG5iX3F1ZXVlcywgdWludDMyX3QgcXVl
dWVfc2l6ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDY0X3QgKmZs
b3dfaXRlbXMsIHVpbnQ2NF90ICpmbG93X2FjdGlvbnMsIHVpbnQ2NF90ICpmbG93X2F0dHJzLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50OF90IGZsb3dfZ3JvdXAsIHVp
bnQzMl90IHJ1bGVzX2NvdW50KTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9m
bG93X3BvcnRfaW5mbyBwb3J0X2luZm8gPSB7MH07PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0
ZV9mbG93X3F1ZXVlX2luZm8gcXVldWVfaW5mbyA9IHswfTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1
Y3QgcnRlX2Zsb3dfZXJyb3IgZXJyb3IgPSB7MH07PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0
ZV9mbG93X3BvcnRfYXR0ciBwb3J0X2F0dHIgPSB7MH07PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0
IHJ0ZV9mbG93X3F1ZXVlX2F0dHIgcXVldWVfYXR0cjs8YnI+DQorwqAgwqAgwqAgwqBjb25zdCBz
dHJ1Y3QgcnRlX2Zsb3dfcXVldWVfYXR0ciAqKnF1ZXVlX2F0dHJfbGlzdDs8YnI+DQorwqAgwqAg
wqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfcGF0dGVybl90ZW1wbGF0ZV9hdHRyIHB0X2F0dHIgPSB7MH07
PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbnNfdGVtcGxhdGVfYXR0ciBh
dF9hdHRyID0gezB9Ozxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBydGVfZmxvd190ZW1wbGF0ZV90
YWJsZV9hdHRyIHRhYmxlX2F0dHIgPSB7MH07PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9m
bG93X2l0ZW0gcGF0dGVybltNQVhfSVRFTVNfTlVNXTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3Qg
cnRlX2Zsb3dfYWN0aW9uIGFjdGlvbnNbTUFYX0FDVElPTlNfTlVNXTs8YnI+DQorwqAgwqAgwqAg
wqBzdHJ1Y3QgcnRlX2Zsb3dfYWN0aW9uIGFjdGlvbl9tYXNrc1tNQVhfQUNUSU9OU19OVU1dOzxi
cj4NCivCoCDCoCDCoCDCoHNpemVfdCBpdGVtX3NwZWNfc2l6ZXNbTUFYX0lURU1TX05VTV07PGJy
Pg0KK8KgIMKgIMKgIMKgc2l6ZV90IGFjdGlvbl9jb25mX3NpemVzW01BWF9BQ1RJT05TX05VTV07
PGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3Qgbl9pdGVtcywgbl9hY3Rpb25zOzxicj4NCivCoCDC
oCDCoCDCoHN0cnVjdCBhc3luY19mbG93X3Jlc291cmNlcyAqcmVzOzxicj4NCivCoCDCoCDCoCDC
oGJvb2wgbmVlZF93aXJlX29yaWdfdGFibGUgPSBmYWxzZTs8YnI+DQorwqAgwqAgwqAgwqB1aW50
MzJfdCBpOzxicj4NCivCoCDCoCDCoCDCoGludCByZXQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oGlmIChwb3J0X2lkICZndDs9IE1BWF9QT1JUUyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gLTE7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJlcyA9ICZhbXA7cG9ydF9yZXNv
dXJjZXNbcG9ydF9pZF07PGJyPg0KK8KgIMKgIMKgIMKgbWVtc2V0KHJlcywgMCwgc2l6ZW9mKCpy
ZXMpKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogUXVlcnkgcG9ydCBmbG93IGluZm8gKi88
YnI+DQorwqAgwqAgwqAgwqByZXQgPSBydGVfZmxvd19pbmZvX2dldChwb3J0X2lkLCAmYW1wO3Bv
cnRfaW5mbywgJmFtcDtxdWV1ZV9pbmZvLCAmYW1wO2Vycm9yKTs8YnI+DQorwqAgwqAgwqAgwqBp
ZiAocmV0ICE9IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVy
ciwgJnF1b3Q7UG9ydCAldTogcnRlX2Zsb3dfaW5mb19nZXQgZmFpbGVkOiAlc1xuJnF1b3Q7LCBw
b3J0X2lkLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm9yLm1l
c3NhZ2UgPyBlcnJvci5tZXNzYWdlIDogJnF1b3Q7KG5vIG1lc3NhZ2UpJnF1b3Q7KTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCivCoCDCoCDCoCDCoH08YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHBvcnRfaW5mby5tYXhfbmJfcXVldWVzID09IDAgfHwg
cXVldWVfaW5mby5tYXhfc2l6ZSA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZnByaW50ZihzdGRlcnIsICZxdW90O1BvcnQgJXU6IHJ0ZV9mbG93X2luZm9fZ2V0IHJlcG9ydHMg
dGhhdCBubyBxdWV1ZXMgYXJlIHN1cHBvcnRlZFxuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcnRfaWQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiAtMTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oC8qIExpbWl0IHRvIGRldmljZSBjYXBhYmlsaXRpZXMgaWYgcmVwb3J0ZWQgKi88YnI+DQorwqAg
wqAgwqAgwqBpZiAocG9ydF9pbmZvLm1heF9uYl9xdWV1ZXMgIT0gMCAmYW1wOyZhbXA7IHBvcnRf
aW5mby5tYXhfbmJfcXVldWVzICE9IFVJTlQzMl9NQVggJmFtcDsmYW1wOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoG5iX3F1ZXVlcyAmZ3Q7IHBvcnRfaW5mby5tYXhfbmJfcXVldWVzKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5iX3F1ZXVlcyA9IHBvcnRfaW5mby5tYXhfbmJfcXVldWVz
Ozxicj4NCivCoCDCoCDCoCDCoGlmIChxdWV1ZV9pbmZvLm1heF9zaXplICE9IDAgJmFtcDsmYW1w
OyBxdWV1ZV9pbmZvLm1heF9zaXplICE9IFVJTlQzMl9NQVggJmFtcDsmYW1wOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoHF1ZXVlX3NpemUgJmd0OyBxdWV1ZV9pbmZvLm1heF9zaXplKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHF1ZXVlX3NpemUgPSBxdWV1ZV9pbmZvLm1heF9zaXplOzxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBTbG90IHJpbmcgdXNlcyBiaXRtYXNrIHdyYXBwaW5n
LCBzbyBxdWV1ZV9zaXplIG11c3QgYmUgcG93ZXIgb2YgMiAqLzxicj4NCivCoCDCoCDCoCDCoHF1
ZXVlX3NpemUgPSBydGVfYWxpZ24zMnByZXZwb3cyKHF1ZXVlX3NpemUpOzxicj4NCivCoCDCoCDC
oCDCoGlmIChxdWV1ZV9zaXplID09IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBm
cHJpbnRmKHN0ZGVyciwgJnF1b3Q7UG9ydCAldTogcXVldWVfc2l6ZSBpcyAwIGFmdGVyIHJvdW5k
aW5nXG4mcXVvdDssIHBvcnRfaWQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biAtRUlOVkFMOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgZm9y
IChpID0gMDsgaSAmbHQ7IE1BWF9BVFRSU19OVU07IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIChmbG93X2F0dHJzW2ldID09IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KGZsb3dfYXR0cnNbaV0gJmFtcDsgSU5HUkVTUyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBwdF9hdHRyLmluZ3Jlc3MgPSAxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGVsc2UgaWYgKGZsb3dfYXR0cnNbaV0gJmFtcDsgRUdSRVNTKTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHB0X2F0dHIuZWdyZXNzID0gMTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlIGlmIChmbG93X2F0dHJzW2ldICZhbXA7IFRSQU5TRkVS
KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHB0X2F0dHIudHJhbnNm
ZXIgPSAxOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAvKiBFbmFibGUgcmVs
YXhlZCBtYXRjaGluZyBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlICovPGJyPg0KK8KgIMKgIMKgIMKg
cHRfYXR0ci5yZWxheGVkX21hdGNoaW5nID0gMTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgbWVt
c2V0KHBhdHRlcm4sIDAsIHNpemVvZihwYXR0ZXJuKSk7PGJyPg0KK8KgIMKgIMKgIMKgbWVtc2V0
KGFjdGlvbnMsIDAsIHNpemVvZihhY3Rpb25zKSk7PGJyPg0KK8KgIMKgIMKgIMKgbWVtc2V0KGFj
dGlvbl9tYXNrcywgMCwgc2l6ZW9mKGFjdGlvbl9tYXNrcykpOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqAvKiBGaWxsIHRlbXBsYXRlcyBhbmQgZ2F0aGVyIHBlci1pdGVtL2FjdGlvbiBzaXplcyAq
Lzxicj4NCivCoCDCoCDCoCDCoGZpbGxfaXRlbXNfdGVtcGxhdGUocGF0dGVybiwgZmxvd19pdGVt
cywgMCwgMCwgaXRlbV9zcGVjX3NpemVzLCAmYW1wO25faXRlbXMpOzxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqBhdF9hdHRyLmluZ3Jlc3MgPSBwdF9hdHRyLmluZ3Jlc3M7PGJyPg0KK8KgIMKgIMKg
IMKgYXRfYXR0ci5lZ3Jlc3MgPSBwdF9hdHRyLmVncmVzczs8YnI+DQorwqAgwqAgwqAgwqBhdF9h
dHRyLnRyYW5zZmVyID0gcHRfYXR0ci50cmFuc2Zlcjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
ZmlsbF9hY3Rpb25zX3RlbXBsYXRlKGFjdGlvbnMsIGFjdGlvbl9tYXNrcywgZmxvd19hY3Rpb25z
LCAmYW1wO3BvcnRfYXR0ciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAmYW1wO25lZWRfd2lyZV9vcmlnX3RhYmxlLCBhY3Rpb25fY29uZl9zaXplcywg
JmFtcDtuX2FjdGlvbnMpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBmaWxsX2FjdGlvbnNf
dGVtcGxhdGUgY291bnQgdGhlIG51bWJlciBvZiBhY3Rpb25zIHRoYXQgcmVxdWlyZSBlYWNoIGtp
bmQgb2Ygb2JqZWN0LDxicj4NCivCoCDCoCDCoCDCoCAqIHNvIHdlIG11bHRpcGx5IGJ5IHRoZSBu
dW1iZXIgb2YgcnVsZXMgdG8gaGF2ZSBjb3JyZWN0IG51bWJlciAqLzxicj4NCivCoCDCoCDCoCDC
oHBvcnRfYXR0ci5uYl9jb3VudGVycyAqPSBydWxlc19jb3VudDs8YnI+DQorwqAgwqAgwqAgwqBw
b3J0X2F0dHIubmJfYWdpbmdfb2JqZWN0cyAqPSBydWxlc19jb3VudDs8YnI+DQorwqAgwqAgwqAg
wqBwb3J0X2F0dHIubmJfbWV0ZXJzICo9IHJ1bGVzX2NvdW50Ozxicj4NCivCoCDCoCDCoCDCoHBv
cnRfYXR0ci5uYl9jb25uX3RyYWNrcyAqPSBydWxlc19jb3VudDs8YnI+DQorwqAgwqAgwqAgwqBw
b3J0X2F0dHIubmJfcXVvdGFzICo9IHJ1bGVzX2NvdW50Ozxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqB0YWJsZV9hdHRyLmZsb3dfYXR0ci5ncm91cCA9IGZsb3dfZ3JvdXA7PGJyPg0KK8KgIMKgIMKg
IMKgdGFibGVfYXR0ci5mbG93X2F0dHIucHJpb3JpdHkgPSAwOzxicj4NCivCoCDCoCDCoCDCoHRh
YmxlX2F0dHIuZmxvd19hdHRyLmluZ3Jlc3MgPSBwdF9hdHRyLmluZ3Jlc3M7PGJyPg0KK8KgIMKg
IMKgIMKgdGFibGVfYXR0ci5mbG93X2F0dHIuZWdyZXNzID0gcHRfYXR0ci5lZ3Jlc3M7PGJyPg0K
K8KgIMKgIMKgIMKgdGFibGVfYXR0ci5mbG93X2F0dHIudHJhbnNmZXIgPSBwdF9hdHRyLnRyYW5z
ZmVyOzxicj4NCivCoCDCoCDCoCDCoHRhYmxlX2F0dHIubmJfZmxvd3MgPSBydWxlc19jb3VudDs8
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHB0X2F0dHIudHJhbnNmZXIgJmFtcDsmYW1wOyBu
ZWVkX3dpcmVfb3JpZ190YWJsZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0YWJsZV9h
dHRyLnNwZWNpYWxpemUgPSBSVEVfRkxPV19UQUJMRV9TUEVDSUFMSVpFX1RSQU5TRkVSX1dJUkVf
T1JJRzs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcXVldWVfYXR0cl9saXN0ID0gbWFsbG9jKHNp
emVvZigqcXVldWVfYXR0cl9saXN0KSAqIG5iX3F1ZXVlcyk7PGJyPg0KK8KgIMKgIMKgIMKgaWYg
KHF1ZXVlX2F0dHJfbGlzdCA9PSBOVUxMKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZnByaW50ZihzdGRlcnIsICZxdW90O1BvcnQgJXU6IGZhaWxlZCB0byBhbGxvY2F0ZSBxdWV1ZV9h
dHRyX2xpc3RcbiZxdW90OywgcG9ydF9pZCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0dXJuIC1FTk9NRU07PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqBxdWV1ZV9hdHRyLnNpemUgPSBxdWV1ZV9zaXplOzxicj4NCivCoCDCoCDCoCDCoGZvciAoaSA9
IDA7IGkgJmx0OyBuYl9xdWV1ZXM7IGkrKyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBx
dWV1ZV9hdHRyX2xpc3RbaV0gPSAmYW1wO3F1ZXVlX2F0dHI7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoHJldCA9IHJ0ZV9mbG93X2NvbmZpZ3VyZShwb3J0X2lkLCAmYW1wO3BvcnRfYXR0ciwgbmJf
cXVldWVzLCBxdWV1ZV9hdHRyX2xpc3QsICZhbXA7ZXJyb3IpOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBmcmVlKHF1ZXVlX2F0dHJfbGlzdCk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChy
ZXQgIT0gMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAm
cXVvdDtQb3J0ICV1OiBydGVfZmxvd19jb25maWd1cmUgZmFpbGVkIChyZXQ9JWQsIHR5cGU9JWQp
OiAlc1xuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBv
cnRfaWQsIHJldCwgZXJyb3IudHlwZSwgZXJyb3IubWVzc2FnZSA/IGVycm9yLm1lc3NhZ2UgOiAm
cXVvdDsobm8gbWVzc2FnZSkmcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dHVybiByZXQ7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBD
cmVhdGUgcGF0dGVybiB0ZW1wbGF0ZSAqLzxicj4NCivCoCDCoCDCoCDCoHJlcy0mZ3Q7cGF0dGVy
bl90ZW1wbGF0ZSA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2Zsb3dfcGF0dGVy
bl90ZW1wbGF0ZV9jcmVhdGUocG9ydF9pZCwgJmFtcDtwdF9hdHRyLCBwYXR0ZXJuLCAmYW1wO2Vy
cm9yKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmVzLSZndDtwYXR0ZXJuX3RlbXBsYXRlID09IE5V
TEwpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7
UG9ydCAldTogcGF0dGVybiB0ZW1wbGF0ZSBjcmVhdGUgZmFpbGVkOiAlc1xuJnF1b3Q7LCBwb3J0
X2lkLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm9yLm1lc3Nh
Z2UgPyBlcnJvci5tZXNzYWdlIDogJnF1b3Q7KG5vIG1lc3NhZ2UpJnF1b3Q7KTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAvKiBDcmVhdGUgYWN0aW9ucyB0ZW1wbGF0ZSAqLzxicj4NCivCoCDC
oCDCoCDCoHJlcy0mZ3Q7YWN0aW9uc190ZW1wbGF0ZSA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcnRlX2Zsb3dfYWN0aW9uc190ZW1wbGF0ZV9jcmVhdGUocG9ydF9pZCwgJmFtcDthdF9h
dHRyLCBhY3Rpb25zLCBhY3Rpb25fbWFza3MsICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDC
oGlmIChyZXMtJmd0O2FjdGlvbnNfdGVtcGxhdGUgPT0gTlVMTCkgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDtQb3J0ICV1OiBhY3Rpb25zIHRlbXBs
YXRlIGNyZWF0ZSBmYWlsZWQ6ICVzXG4mcXVvdDssIHBvcnRfaWQsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJyb3IubWVzc2FnZSA/IGVycm9yLm1lc3NhZ2UgOiAm
cXVvdDsobm8gbWVzc2FnZSkmcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0
ZV9mbG93X3BhdHRlcm5fdGVtcGxhdGVfZGVzdHJveShwb3J0X2lkLCByZXMtJmd0O3BhdHRlcm5f
dGVtcGxhdGUsICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlcy0m
Z3Q7cGF0dGVybl90ZW1wbGF0ZSA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0dXJuIC0xOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyog
Q3JlYXRlIHRlbXBsYXRlIHRhYmxlICovPGJyPg0KK8KgIMKgIMKgIMKgcmVzLSZndDt0YWJsZSA9
IHJ0ZV9mbG93X3RlbXBsYXRlX3RhYmxlX2NyZWF0ZShwb3J0X2lkLCAmYW1wO3RhYmxlX2F0dHIs
ICZhbXA7cmVzLSZndDtwYXR0ZXJuX3RlbXBsYXRlLCAxLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCZhbXA7cmVzLSZndDthY3Rpb25zX3RlbXBsYXRlLCAxLCAmYW1wO2Vycm9yKTs8YnI+DQor
wqAgwqAgwqAgwqBpZiAocmVzLSZndDt0YWJsZSA9PSBOVUxMKSB7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O1BvcnQgJXU6IHRlbXBsYXRlIHRhYmxl
IGNyZWF0ZSBmYWlsZWQ6ICVzXG4mcXVvdDssIHBvcnRfaWQsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJyb3IubWVzc2FnZSA/IGVycm9yLm1lc3NhZ2UgOiAmcXVv
dDsobm8gbWVzc2FnZSkmcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9m
bG93X2FjdGlvbnNfdGVtcGxhdGVfZGVzdHJveShwb3J0X2lkLCByZXMtJmd0O2FjdGlvbnNfdGVt
cGxhdGUsICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9mbG93
X3BhdHRlcm5fdGVtcGxhdGVfZGVzdHJveShwb3J0X2lkLCByZXMtJmd0O3BhdHRlcm5fdGVtcGxh
dGUsICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlcy0mZ3Q7cGF0
dGVybl90ZW1wbGF0ZSA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzLSZn
dDthY3Rpb25zX3RlbXBsYXRlID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gLTE7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBB
bGxvY2F0ZSBhbmQgcHJlLWluaXRpYWxpemUgcGVyLXNsb3QgZmxhdCBidWZmZXJzICovPGJyPg0K
K8KgIMKgIMKgIMKgcmV0ID0gaW5pdF9zbG90X3Bvb2wocmVzLCBuYl9xdWV1ZXMsIHF1ZXVlX3Np
emUsIHBhdHRlcm4sIG5faXRlbXMsIGl0ZW1fc3BlY19zaXplcywgYWN0aW9ucyw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbl9hY3Rpb25zLCBhY3Rpb25f
Y29uZl9zaXplcyk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJldCAhPSAwKSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O1BvcnQgJXU6IHNsb3QgcG9v
bCBpbml0IGZhaWxlZFxuJnF1b3Q7LCBwb3J0X2lkKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBydGVfZmxvd190ZW1wbGF0ZV90YWJsZV9kZXN0cm95KHBvcnRfaWQsIHJlcy0mZ3Q7dGFi
bGUsICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9mbG93X2Fj
dGlvbnNfdGVtcGxhdGVfZGVzdHJveShwb3J0X2lkLCByZXMtJmd0O2FjdGlvbnNfdGVtcGxhdGUs
ICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9mbG93X3BhdHRl
cm5fdGVtcGxhdGVfZGVzdHJveShwb3J0X2lkLCByZXMtJmd0O3BhdHRlcm5fdGVtcGxhdGUsICZh
bXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlcy0mZ3Q7dGFibGUgPSBO
VUxMOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlcy0mZ3Q7YWN0aW9uc190ZW1wbGF0
ZSA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVzLSZndDtwYXR0ZXJuX3Rl
bXBsYXRlID0gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxi
cj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmVzLSZndDt0YWJsZV9j
YXBhY2l0eSA9IHJ1bGVzX2NvdW50Ozxicj4NCivCoCDCoCDCoCDCoHJlcy0mZ3Q7aW5pdGlhbGl6
ZWQgPSB0cnVlOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBwcmludGYoJnF1b3Q7OjogUG9ydCAl
dTogQXN5bmMgZmxvdyBlbmdpbmUgaW5pdGlhbGl6ZWQgKHF1ZXVlcz0ldSwgcXVldWVfc2l6ZT0l
dSlcbiZxdW90OywgcG9ydF9pZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmJfcXVldWVz
LCBxdWV1ZV9zaXplKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KK308
YnI+DQorPGJyPg0KK3N0cnVjdCBydGVfZmxvdyAqPGJyPg0KK2FzeW5jX2dlbmVyYXRlX2Zsb3co
dWludDE2X3QgcG9ydF9pZCwgdWludDMyX3QgcXVldWVfaWQsIHVpbnQzMl90IGNvdW50ZXIsIHVp
bnQxNl90IGhhaXJwaW5xLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ2
NF90IGVuY2FwX2RhdGEsIHVpbnQ2NF90IGRlY2FwX2RhdGEsIHVpbnQxNl90IGRzdF9wb3J0LCB1
aW50OF90IGNvcmVfaWR4LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ4
X3QgcnhfcXVldWVzX2NvdW50LCBib29sIHVuaXF1ZV9kYXRhLCBib29sIHBvc3Rwb25lLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBydGVfZmxvd19lcnJvciAqZXJy
b3IpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYXN5bmNfZmxvd19yZXNvdXJjZXMg
KnJlczs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYXN5bmNfZmxvd19xdWV1ZSAqcTs8YnI+DQor
wqAgwqAgwqAgwqB1aW50OF90ICpzbG90Ozxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IGlkeCwg
aXRlbXNfYXJyYXlfYnl0ZXM7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X2l0ZW0g
Kml0ZW1zOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBydGVfZmxvd19hY3Rpb24gKmFjdGlvbnM7
PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X29wX2F0dHIgb3BfYXR0ciA9IHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAucG9zdHBvbmUgPSBwb3N0cG9uZSw8YnI+DQorwqAg
wqAgwqAgwqB9Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAocG9ydF9pZCAmZ3Q7PSBNQVhf
UE9SVFMpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfZmxvd19lcnJvcl9zZXQo
ZXJyb3IsIEVJTlZBTCwgUlRFX0ZMT1dfRVJST1JfVFlQRV9VTlNQRUNJRklFRCwgTlVMTCw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1
b3Q7SW52YWxpZCBwb3J0IElEJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJl
cyA9ICZhbXA7cG9ydF9yZXNvdXJjZXNbcG9ydF9pZF07PGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFy
ZXMtJmd0O2luaXRpYWxpemVkKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2Zs
b3dfZXJyb3Jfc2V0KGVycm9yLCBFSU5WQUwsIFJURV9GTE9XX0VSUk9SX1RZUEVfVU5TUEVDSUZJ
RUQsIE5VTEwsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICZxdW90O0FzeW5jIGZsb3cgcmVzb3VyY2VzIG5vdCBpbml0aWFsaXplZCZxdW90
Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIE5VTEw7PGJyPg0KK8KgIMKg
IMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAocXVldWVfaWQgJmd0Oz0gcmVzLSZn
dDtuYl9xdWV1ZXMpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfZmxvd19lcnJv
cl9zZXQoZXJyb3IsIEVJTlZBTCwgUlRFX0ZMT1dfRVJST1JfVFlQRV9VTlNQRUNJRklFRCwgTlVM
TCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJnF1b3Q7SW52YWxpZCBxdWV1ZSBJRCZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqAvKiBQaWNrIHRoZSBuZXh0IHNsb3QgZnJvbSB0aGlzIHF1ZXVlJiMzOTtzIHJpbmcgKi88
YnI+DQorwqAgwqAgwqAgwqBxID0gJmFtcDtyZXMtJmd0O3F1ZXVlc1txdWV1ZV9pZF07PGJyPg0K
K8KgIMKgIMKgIMKgaWR4ID0gcS0mZ3Q7aGVhZDs8YnI+DQorwqAgwqAgwqAgwqBxLSZndDtoZWFk
ID0gKGlkeCArIDEpICZhbXA7IChyZXMtJmd0O3Nsb3RzX3Blcl9xdWV1ZSAtIDEpOzxicj4NCivC
oCDCoCDCoCDCoHNsb3QgPSBxLSZndDtzbG90cyArIChzaXplX3QpaWR4ICogcmVzLSZndDtzbG90
X3NpemU7PGJyPg0KK8KgIMKgIMKgIMKgaXRlbXNfYXJyYXlfYnl0ZXMgPSByZXMtJmd0O25faXRl
bXMgKiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2l0ZW0pOzxicj4NCivCoCDCoCDCoCDCoGl0ZW1z
ID0gKHN0cnVjdCBydGVfZmxvd19pdGVtICopc2xvdDs8YnI+DQorwqAgwqAgwqAgwqBhY3Rpb25z
ID0gKHN0cnVjdCBydGVfZmxvd19hY3Rpb24gKikoc2xvdCArIGl0ZW1zX2FycmF5X2J5dGVzKTs8
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogVXBkYXRlIG9ubHkgcGVyLWZsb3cgdmFyeWluZyB2
YWx1ZXMgKi88YnI+DQorwqAgwqAgwqAgwqB1cGRhdGVfaXRlbV92YWx1ZXMoaXRlbXMsIGNvdW50
ZXIpOzxicj4NCivCoCDCoCDCoCDCoHVwZGF0ZV9hY3Rpb25fdmFsdWVzKGFjdGlvbnMsIGNvdW50
ZXIsIGhhaXJwaW5xLCBlbmNhcF9kYXRhLCBkZWNhcF9kYXRhLCBjb3JlX2lkeCw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdW5pcXVlX2RhdGEsIHJ4X3F1
ZXVlc19jb3VudCwgZHN0X3BvcnQpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gcnRl
X2Zsb3dfYXN5bmNfY3JlYXRlKHBvcnRfaWQsIHF1ZXVlX2lkLCAmYW1wO29wX2F0dHIsIHJlcy0m
Z3Q7dGFibGUsIGl0ZW1zLCAwLCBhY3Rpb25zLCAwLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBlcnJvcik7PGJyPg0KK308
YnI+DQorPGJyPg0KK3ZvaWQ8YnI+DQorYXN5bmNfZmxvd19jbGVhbnVwX3BvcnQodWludDE2X3Qg
cG9ydF9pZCk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhc3luY19mbG93X3Jlc291
cmNlcyAqcmVzOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBydGVfZmxvd19lcnJvciBlcnJvcjs8
YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3dfb3BfcmVzdWx0IHJlc3VsdHNbNjRdOzxi
cj4NCivCoCDCoCDCoCDCoGludCByZXQsIGk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChw
b3J0X2lkICZndDs9IE1BWF9QT1JUUyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm47PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJlcyA9ICZhbXA7cG9ydF9yZXNvdXJjZXNbcG9y
dF9pZF07PGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFyZXMtJmd0O2luaXRpYWxpemVkKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyog
RHJhaW4gYW55IHBlbmRpbmcgYXN5bmMgY29tcGxldGlvbnMgZnJvbSBmbG93IGZsdXNoICovPGJy
Pg0KK8KgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IERSQUlOX01BWF9JVEVSQVRJT05TOyBp
KyspIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfZmxvd19wdXNoKHBvcnRfaWQs
IDAsICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IHJ0ZV9m
bG93X3B1bGwocG9ydF9pZCwgMCwgcmVzdWx0cywgNjQsICZhbXA7ZXJyb3IpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgJmx0Oz0gMCk8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoGlmIChyZXMtJmd0O3RhYmxlICE9IE5VTEwpIHs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBydGVfZmxvd190ZW1wbGF0ZV90YWJsZV9kZXN0cm95KHBvcnRfaWQsIHJl
cy0mZ3Q7dGFibGUsICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
cy0mZ3Q7dGFibGUgPSBOVUxMOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKg
IMKgIMKgaWYgKHJlcy0mZ3Q7YWN0aW9uc190ZW1wbGF0ZSAhPSBOVUxMKSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcnRlX2Zsb3dfYWN0aW9uc190ZW1wbGF0ZV9kZXN0cm95KHBvcnRf
aWQsIHJlcy0mZ3Q7YWN0aW9uc190ZW1wbGF0ZSwgJmFtcDtlcnJvcik7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmVzLSZndDthY3Rpb25zX3RlbXBsYXRlID0gTlVMTDs8YnI+DQorwqAg
wqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChyZXMtJmd0O3BhdHRlcm5fdGVt
cGxhdGUgIT0gTlVMTCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9mbG93X3Bh
dHRlcm5fdGVtcGxhdGVfZGVzdHJveShwb3J0X2lkLCByZXMtJmd0O3BhdHRlcm5fdGVtcGxhdGUs
ICZhbXA7ZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlcy0mZ3Q7cGF0dGVy
bl90ZW1wbGF0ZSA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBmcmVlKHJlcy0mZ3Q7cXVldWVzKTs8YnI+DQorwqAgwqAgwqAgwqByZXMtJmd0O3F1ZXVl
cyA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgZnJlZShyZXMtJmd0O3Nsb3RfcG9vbCk7PGJyPg0K
K8KgIMKgIMKgIMKgcmVzLSZndDtzbG90X3Bvb2wgPSBOVUxMOzxicj4NCivCoCDCoCDCoCDCoGZy
ZWUocmVzLSZndDtzaGFyZWRfbWFza3MpOzxicj4NCivCoCDCoCDCoCDCoHJlcy0mZ3Q7c2hhcmVk
X21hc2tzID0gTlVMTDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmVzLSZndDtpbml0aWFsaXpl
ZCA9IGZhbHNlOzxicj4NCit9PGJyPg0KZGlmZiAtLWdpdCBhL2FwcC90ZXN0LWZsb3ctcGVyZi9h
c3luY19mbG93LmggYi9hcHAvdGVzdC1mbG93LXBlcmYvYXN5bmNfZmxvdy5oPGJyPg0KbmV3IGZp
bGUgbW9kZSAxMDA2NDQ8YnI+DQppbmRleCAwMDAwMDAwMDAwLi44YzEyOTI0YmM2PGJyPg0KLS0t
IC9kZXYvbnVsbDxicj4NCisrKyBiL2FwcC90ZXN0LWZsb3ctcGVyZi9hc3luY19mbG93Lmg8YnI+
DQpAQCAtMCwwICsxLDU0IEBAPGJyPg0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBCU0Qt
My1DbGF1c2U8YnI+DQorICogQ29weXJpZ2h0IDIwMjYgTWF4aW1lIFBlaW0gJmx0OzxhIGhyZWY9
Im1haWx0bzptYXhpbWUucGVpbUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5tYXhpbWUucGVp
bUBnbWFpbC5jb208L2E+Jmd0Ozxicj4NCisgKjxicj4NCisgKiBUaGlzIGZpbGUgY29udGFpbnMg
dGhlIGFzeW5jIGZsb3cgQVBJIHJlbGF0ZWQgZGVmaW5pdGlvbnM8YnI+DQorICogYW5kIGZ1bmN0
aW9uIGRlY2xhcmF0aW9ucy48YnI+DQorICovPGJyPg0KKzxicj4NCisjaWZuZGVmIEZMT1dfUEVS
Rl9BU1lOQ19GTE9XPGJyPg0KKyNkZWZpbmUgRkxPV19QRVJGX0FTWU5DX0ZMT1c8YnI+DQorPGJy
Pg0KKyNpbmNsdWRlICZsdDtydGVfZmxvdy5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c3RkYm9v
bC5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7c3RkaW50LmgmZ3Q7PGJyPg0KKzxicj4NCisjaW5j
bHVkZSAmcXVvdDtjb25maWcuaCZxdW90Ozxicj4NCis8YnI+DQorLyogUGVyLXF1ZXVlIHNsb3Qg
cmluZyDigJQgdHJhY2tzIHdoaWNoIHNsb3QgdG8gdXNlIG5leHQgKi88YnI+DQorc3RydWN0IGFz
eW5jX2Zsb3dfcXVldWUgezxicj4NCivCoCDCoCDCoCDCoHVpbnQ4X3QgKnNsb3RzOyAvKiBwb2lu
dGVyIHRvIHRoaXMgcXVldWUmIzM5O3MgcmVnaW9uIHdpdGhpbiBzbG90X3Bvb2wgKi88YnI+DQor
wqAgwqAgwqAgwqB1aW50MzJfdCBoZWFkO8KgIC8qIG5leHQgc2xvdCBpbmRleCAod3JhcHMgbW9k
IHNsb3RzX3Blcl9xdWV1ZSkgKi88YnI+DQorfTs8YnI+DQorPGJyPg0KKy8qIFBlci1wb3J0IGFz
eW5jIGZsb3cgcmVzb3VyY2VzICovPGJyPg0KK3N0cnVjdCBhc3luY19mbG93X3Jlc291cmNlcyB7
PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X3BhdHRlcm5fdGVtcGxhdGUgKnBhdHRl
cm5fdGVtcGxhdGU7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93X2FjdGlvbnNfdGVt
cGxhdGUgKmFjdGlvbnNfdGVtcGxhdGU7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93
X3RlbXBsYXRlX3RhYmxlICp0YWJsZTs8YnI+DQorwqAgwqAgwqAgwqB1aW50OF90ICpzbG90X3Bv
b2w7wqAgwqAgLyogZmxhdCBidWZmZXIgcG9vbCBmb3IgYWxsIHNsb3RzICovPGJyPg0KK8KgIMKg
IMKgIMKgdWludDhfdCAqc2hhcmVkX21hc2tzOyAvKiBzaGFyZWQgaXRlbSBtYXNrIGRhdGEgKG9u
ZSBjb3B5IGZvciBhbGwgc2xvdHMpICovPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGFzeW5jX2Zs
b3dfcXVldWUgKnF1ZXVlczs8YnI+DQorwqAgwqAgwqAgwqB1aW50MzJfdCBzbG90X3NpemU7wqAg
wqAgwqAgwqAvKiBieXRlcyBwZXIgc2xvdCAoY2FjaGUtbGluZSBhbGlnbmVkKSAqLzxicj4NCivC
oCDCoCDCoCDCoHVpbnQzMl90IHNsb3RzX3Blcl9xdWV1ZTsgLyogPSBxdWV1ZV9zaXplICovPGJy
Pg0KK8KgIMKgIMKgIMKgdWludDMyX3QgbmJfcXVldWVzOzxicj4NCivCoCDCoCDCoCDCoHVpbnQz
Ml90IG5faXRlbXM7wqAgwqAvKiBpdGVtIGNvdW50IChleGNsLiBFTkQpICovPGJyPg0KK8KgIMKg
IMKgIMKgdWludDMyX3Qgbl9hY3Rpb25zOyAvKiBhY3Rpb24gY291bnQgKGV4Y2wuIEVORCkgKi88
YnI+DQorwqAgwqAgwqAgwqB1aW50MzJfdCB0YWJsZV9jYXBhY2l0eTs8YnI+DQorwqAgwqAgwqAg
wqBib29sIGluaXRpYWxpemVkOzxicj4NCit9Ozxicj4NCis8YnI+DQorLyogSW5pdGlhbGl6ZSBh
c3luYyBmbG93IGVuZ2luZSBmb3IgYSBwb3J0ICovPGJyPg0KK2ludCBhc3luY19mbG93X2luaXRf
cG9ydCh1aW50MTZfdCBwb3J0X2lkLCB1aW50MzJfdCBuYl9xdWV1ZXMsIHVpbnQzMl90IHF1ZXVl
X3NpemUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQ2NF90
ICpmbG93X2l0ZW1zLCB1aW50NjRfdCAqZmxvd19hY3Rpb25zLCB1aW50NjRfdCAqZmxvd19hdHRy
cyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDhfdCBmbG93
X2dyb3VwLCB1aW50MzJfdCBydWxlc19jb3VudCk7PGJyPg0KKzxicj4NCisvKiBDcmVhdGUgYSBm
bG93IHJ1bGUgYXN5bmNocm9ub3VzbHkgdXNpbmcgcHJlLWFsbG9jYXRlZCBzbG90ICovPGJyPg0K
K3N0cnVjdCBydGVfZmxvdyAqYXN5bmNfZ2VuZXJhdGVfZmxvdyh1aW50MTZfdCBwb3J0X2lkLCB1
aW50MzJfdCBxdWV1ZV9pZCwgdWludDMyX3QgY291bnRlciw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDE2X3QgaGFpcnBpbnEs
IHVpbnQ2NF90IGVuY2FwX2RhdGEsIHVpbnQ2NF90IGRlY2FwX2RhdGEsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQxNl90IGRz
dF9wb3J0LCB1aW50OF90IGNvcmVfaWR4LCB1aW50OF90IHJ4X3F1ZXVlc19jb3VudCw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYm9v
bCB1bmlxdWVfZGF0YSwgYm9vbCBwb3N0cG9uZSwgc3RydWN0IHJ0ZV9mbG93X2Vycm9yICplcnJv
cik7PGJyPg0KKzxicj4NCisvKiBDbGVhbnVwIGFzeW5jIGZsb3cgcmVzb3VyY2VzIGZvciBhIHBv
cnQgKi88YnI+DQordm9pZCBhc3luY19mbG93X2NsZWFudXBfcG9ydCh1aW50MTZfdCBwb3J0X2lk
KTs8YnI+DQorPGJyPg0KKyNlbmRpZiAvKiBGTE9XX1BFUkZfQVNZTkNfRkxPVyAqLzxicj4NCmRp
ZmYgLS1naXQgYS9hcHAvdGVzdC1mbG93LXBlcmYvaXRlbXNfZ2VuLmMgYi9hcHAvdGVzdC1mbG93
LXBlcmYvaXRlbXNfZ2VuLmM8YnI+DQppbmRleCBjNzQwZTE4MzhmLi41OGYxYzE2Y2Y4IDEwMDY0
NDxicj4NCi0tLSBhL2FwcC90ZXN0LWZsb3ctcGVyZi9pdGVtc19nZW4uYzxicj4NCisrKyBiL2Fw
cC90ZXN0LWZsb3ctcGVyZi9pdGVtc19nZW4uYzxicj4NCkBAIC0zODksMyArMzg5LDYxIEBAIGZp
bGxfaXRlbXMoc3RydWN0IHJ0ZV9mbG93X2l0ZW0gKml0ZW1zLDxicj4NCjxicj4NCsKgIMKgIMKg
IMKgIGl0ZW1zW2l0ZW1zX2NvdW50ZXJdLnR5cGUgPSBSVEVfRkxPV19JVEVNX1RZUEVfRU5EOzxi
cj4NCsKgfTxicj4NCis8YnI+DQorc3RhdGljIHNpemVfdDxicj4NCitpdGVtX3NwZWNfc2l6ZShl
bnVtIHJ0ZV9mbG93X2l0ZW1fdHlwZSB0eXBlKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3dp
dGNoICh0eXBlKSB7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19JVEVNX1RZUEVfRVRI
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9m
bG93X2l0ZW1fZXRoKTs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0lURU1fVFlQRV9W
TEFOOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0
ZV9mbG93X2l0ZW1fdmxhbik7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19JVEVNX1RZ
UEVfSVBWNDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gc2l6ZW9mKHN0cnVj
dCBydGVfZmxvd19pdGVtX2lwdjQpOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfSVRF
TV9UWVBFX0lQVjY6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHNpemVvZihz
dHJ1Y3QgcnRlX2Zsb3dfaXRlbV9pcHY2KTs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9X
X0lURU1fVFlQRV9UQ1A6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHNpemVv
ZihzdHJ1Y3QgcnRlX2Zsb3dfaXRlbV90Y3ApOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZM
T1dfSVRFTV9UWVBFX1VEUDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gc2l6
ZW9mKHN0cnVjdCBydGVfZmxvd19pdGVtX3VkcCk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVf
RkxPV19JVEVNX1RZUEVfVlhMQU46PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IHNpemVvZihzdHJ1Y3QgcnRlX2Zsb3dfaXRlbV92eGxhbik7PGJyPg0KK8KgIMKgIMKgIMKgY2Fz
ZSBSVEVfRkxPV19JVEVNX1RZUEVfVlhMQU5fR1BFOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2l0ZW1fdnhsYW5fZ3BlKTs8YnI+DQor
wqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0lURU1fVFlQRV9HUkU6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuIHNpemVvZihzdHJ1Y3QgcnRlX2Zsb3dfaXRlbV9ncmUpOzxicj4N
CivCoCDCoCDCoCDCoGNhc2UgUlRFX0ZMT1dfSVRFTV9UWVBFX0dFTkVWRTo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gc2l6ZW9mKHN0cnVjdCBydGVfZmxvd19pdGVtX2dlbmV2
ZSk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19JVEVNX1RZUEVfR1RQOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2l0ZW1f
Z3RwKTs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0lURU1fVFlQRV9NRVRBOjxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93X2l0
ZW1fbWV0YSk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19JVEVNX1RZUEVfVEFHOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9mbG93
X2l0ZW1fdGFnKTs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIFJURV9GTE9XX0lURU1fVFlQRV9JQ01Q
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBzaXplb2Yoc3RydWN0IHJ0ZV9m
bG93X2l0ZW1faWNtcCk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBSVEVfRkxPV19JVEVNX1RZUEVf
SUNNUDY6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHNpemVvZihzdHJ1Y3Qg
cnRlX2Zsb3dfaXRlbV9pY21wNik7PGJyPg0KK8KgIMKgIMKgIMKgZGVmYXVsdDo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK308
YnI+DQorPGJyPg0KK3ZvaWQ8YnI+DQorZmlsbF9pdGVtc190ZW1wbGF0ZShzdHJ1Y3QgcnRlX2Zs
b3dfaXRlbSAqaXRlbXMsIHVpbnQ2NF90ICpmbG93X2l0ZW1zLCB1aW50MzJfdCBvdXRlcl9pcF9z
cmMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDhfdCBjb3JlX2lkeCwg
c2l6ZV90ICpzcGVjX3NpemVzLCB1aW50MzJfdCAqbl9pdGVtc19vdXQpPGJyPg0KK3s8YnI+DQor
wqAgwqAgwqAgwqB1aW50MzJfdCBjb3VudDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgZmlsbF9p
dGVtcyhpdGVtcywgZmxvd19pdGVtcywgb3V0ZXJfaXBfc3JjLCBjb3JlX2lkeCk7PGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoC8qIENvdW50IGl0ZW1zIGJlZm9yZSBFTkQgKi88YnI+DQorwqAgwqAg
wqAgwqBmb3IgKGNvdW50ID0gMDsgaXRlbXNbY291bnRdLnR5cGUgIT0gUlRFX0ZMT1dfSVRFTV9U
WVBFX0VORDsgY291bnQrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNwZWNfc2l6
ZXNbY291bnRdID0gaXRlbV9zcGVjX3NpemUoaXRlbXNbY291bnRdLnR5cGUpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC8qIEZvciB0ZW1wbGF0ZXMsIHNldCBzcGVjIHRvIE5VTEwgLSBv
bmx5IG1hc2sgbWF0dGVycyBmb3IgdGVtcGxhdGUgbWF0Y2hpbmcgKi88YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpdGVtc1tjb3VudF0uc3BlYyA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKg
fTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiB0YWtlIEVORCBpbnRvIGFjY291bnQgKi88YnI+
DQorwqAgwqAgwqAgwqAqbl9pdGVtc19vdXQgPSBjb3VudCArIDE7PGJyPg0KK308YnI+DQpkaWZm
IC0tZ2l0IGEvYXBwL3Rlc3QtZmxvdy1wZXJmL2l0ZW1zX2dlbi5oIGIvYXBwL3Rlc3QtZmxvdy1w
ZXJmL2l0ZW1zX2dlbi5oPGJyPg0KaW5kZXggZjRiMGU5YTk4MS4uMDk4N2Y3YmUzYyAxMDA2NDQ8
YnI+DQotLS0gYS9hcHAvdGVzdC1mbG93LXBlcmYvaXRlbXNfZ2VuLmg8YnI+DQorKysgYi9hcHAv
dGVzdC1mbG93LXBlcmYvaXRlbXNfZ2VuLmg8YnI+DQpAQCAtMTUsNCArMTUsMTAgQEA8YnI+DQrC
oHZvaWQgZmlsbF9pdGVtcyhzdHJ1Y3QgcnRlX2Zsb3dfaXRlbSAqaXRlbXMsIHVpbnQ2NF90ICpm
bG93X2l0ZW1zLDxicj4NCsKgIMKgIMKgIMKgIHVpbnQzMl90IG91dGVyX2lwX3NyYywgdWludDhf
dCBjb3JlX2lkeCk7PGJyPg0KPGJyPg0KKy8qIEZpbGwgaXRlbXMgdGVtcGxhdGUgZm9yIGFzeW5j
IGZsb3cgQVBJIChtYXNrcyBvbmx5LCBubyBzcGVjIHZhbHVlcykuPGJyPg0KKyAqIElmIHNwZWNf
c2l6ZXMgaXMgbm9uLU5VTEwsIHBvcHVsYXRlcyBwZXItaXRlbSBzcGVjIHNpemVzIGFuZCBuX2l0
ZW1zX291dC48YnI+DQorICovPGJyPg0KK3ZvaWQgZmlsbF9pdGVtc190ZW1wbGF0ZShzdHJ1Y3Qg
cnRlX2Zsb3dfaXRlbSAqaXRlbXMsIHVpbnQ2NF90ICpmbG93X2l0ZW1zLCB1aW50MzJfdCBvdXRl
cl9pcF9zcmMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQ4
X3QgY29yZV9pZHgsIHNpemVfdCAqc3BlY19zaXplcywgdWludDMyX3QgKm5faXRlbXNfb3V0KTs8
YnI+DQorPGJyPg0KwqAjZW5kaWYgLyogRkxPV19QRVJGX0lURU1TX0dFTiAqLzxicj4NCmRpZmYg
LS1naXQgYS9hcHAvdGVzdC1mbG93LXBlcmYvbWFpbi5jIGIvYXBwL3Rlc3QtZmxvdy1wZXJmL21h
aW4uYzxicj4NCmluZGV4IDY2MzZkMTUxN2YuLjJjNmRlZjk1YzIgMTAwNjQ0PGJyPg0KLS0tIGEv
YXBwL3Rlc3QtZmxvdy1wZXJmL21haW4uYzxicj4NCisrKyBiL2FwcC90ZXN0LWZsb3ctcGVyZi9t
YWluLmM8YnI+DQpAQCAtMzcsMTEgKzM3LDE1IEBAPGJyPg0KwqAjaW5jbHVkZSAmbHQ7cnRlX210
ci5oJmd0Ozxicj4NCsKgI2luY2x1ZGUgJmx0O3J0ZV9vc19zaGltLmgmZ3Q7PGJyPg0KPGJyPg0K
LSNpbmNsdWRlICZxdW90O2NvbmZpZy5oJnF1b3Q7PGJyPg0KwqAjaW5jbHVkZSAmcXVvdDthY3Rp
b25zX2dlbi5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90O2FzeW5jX2Zsb3cuaCZxdW90Ozxi
cj4NCisjaW5jbHVkZSAmcXVvdDtjb25maWcuaCZxdW90Ozxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7
Zmxvd19nZW4uaCZxdW90Ozxicj4NCisjaW5jbHVkZSAmcXVvdDtydGVfYnVpbGRfY29uZmlnLmgm
cXVvdDs8YnI+DQo8YnI+DQrCoCNkZWZpbmUgTUFYX0JBVENIRVNfQ09VTlTCoCDCoCDCoCDCoCDC
oCAxMDA8YnI+DQorI2RlZmluZSBNQVhfQVNZTkNfUVVFVUVfU0laRcKgIMKgIMKgIMKgICgxICZs
dDsmbHQ7IDE0KTxicj4NCisjZGVmaW5lIE1BWF9QVUxMX1JFVFJJRVPCoCDCoCDCoCDCoCDCoCDC
oCAoMSAmbHQ7Jmx0OyAyMCk8YnI+DQrCoCNkZWZpbmUgREVGQVVMVF9SVUxFU19DT1VOVMKgIMKg
IDQwMDAwMDA8YnI+DQrCoCNkZWZpbmUgREVGQVVMVF9SVUxFU19CQVRDSMKgIMKgIMKgMTAwMDAw
PGJyPg0KwqAjZGVmaW5lIERFRkFVTFRfR1JPVVDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAwPGJy
Pg0KQEAgLTU1LDcgKzU5LDYgQEA8YnI+DQrCoCNkZWZpbmUgSEFJUlBJTl9UWF9DT05GX0xPQ0tF
RF9NRU1PUlkgKDB4MDEwMCk8YnI+DQrCoCNkZWZpbmUgSEFJUlBJTl9UWF9DT05GX1JURV9NRU1P
UlnCoCDCoCAoMHgwMjAwKTxicj4NCjxicj4NCi1zdHJ1Y3QgcnRlX2Zsb3cgKmZsb3c7PGJyPg0K
wqBzdGF0aWMgdWludDhfdCBmbG93X2dyb3VwOzxicj4NCjxicj4NCsKgc3RhdGljIHVpbnQ2NF90
IGVuY2FwX2RhdGE7PGJyPg0KQEAgLTgxLDYgKzg0LDkgQEAgc3RhdGljIGJvb2wgZW5hYmxlX2Z3
ZDs8YnI+DQrCoHN0YXRpYyBib29sIHVuaXF1ZV9kYXRhOzxicj4NCsKgc3RhdGljIGJvb2wgcG9s
aWN5X210cjs8YnI+DQrCoHN0YXRpYyBib29sIHBhY2tldF9tb2RlOzxicj4NCitzdGF0aWMgYm9v
bCBhc3luY19tb2RlOzxicj4NCitzdGF0aWMgdWludDMyX3QgYXN5bmNfcXVldWVfc2l6ZSA9IDEw
MjQ7PGJyPg0KK3N0YXRpYyB1aW50MzJfdCBhc3luY19wdXNoX2JhdGNoID0gMjU2Ozxicj4NCjxi
cj4NCsKgc3RhdGljIHVpbnQ4X3QgcnhfcXVldWVzX2NvdW50Ozxicj4NCsKgc3RhdGljIHVpbnQ4
X3QgdHhfcXVldWVzX2NvdW50Ozxicj4NCkBAIC01OTgsNiArNjA0LDI5IEBAIHVzYWdlKGNoYXIg
KnByb2duYW1lKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O0VuY2FwcGVkIGRh
dGEgaXMgZml4ZWQgd2l0aCBwYXR0ZXJuOiBldGhlcixpcHY0LHVkcCx2eGxhblxuJnF1b3Q7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7V2l0aCBmaXhlZCB2YWx1ZXNcbiZxdW90
Oyk7PGJyPg0KwqAgwqAgwqAgwqAgcHJpbnRmKCZxdW90O8KgIC0tdnhsYW4tZGVjYXA6IGFkZCB2
eGxhbl9kZWNhcCBhY3Rpb24gdG8gZmxvdyBhY3Rpb25zXG4mcXVvdDspOzxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqBwcmludGYoJnF1b3Q7XG5Bc3luYyBmbG93IEFQSSBvcHRpb25zOlxuJnF1b3Q7
KTs8YnI+DQorwqAgwqAgwqAgwqBwcmludGYoJnF1b3Q7wqAgLS1hc3luYzogZW5hYmxlIGFzeW5j
IGZsb3cgQVBJIG1vZGVcbiZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgcHJpbnRmKCZxdW90O8Kg
IC0tYXN5bmMtcXVldWUtc2l6ZT1OOiBzaXplIG9mIGVhY2ggYXN5bmMgcXVldWUsJnF1b3Q7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90OyBkZWZhdWx0IGlzIDEwMjRcbiZxdW90Oyk7
PGJyPg0KK8KgIMKgIMKgIMKgcHJpbnRmKCZxdW90O8KgIC0tYXN5bmMtcHVzaC1iYXRjaD1OOiBm
bG93cyB0byBiYXRjaCBiZWZvcmUgcHVzaCwmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJnF1b3Q7IGRlZmF1bHQgaXMgMjU2XG4mcXVvdDspOzxicj4NCit9PGJyPg0KKzxicj4NCitz
dGF0aWMgaW5saW5lIHVpbnQzMl90PGJyPg0KK3ByZXZfcG93ZXJfb2ZfdHdvKHVpbnQzMl90IHgp
PGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqB1aW50MzJfdCBzYXZlZCA9IHg7PGJyPg0KK8KgIMKg
IMKgIMKgeC0tOzxicj4NCivCoCDCoCDCoCDCoHggfD0geCAmZ3Q7Jmd0OyAxOzxicj4NCivCoCDC
oCDCoCDCoHggfD0geCAmZ3Q7Jmd0OyAyOzxicj4NCivCoCDCoCDCoCDCoHggfD0geCAmZ3Q7Jmd0
OyA0Ozxicj4NCivCoCDCoCDCoCDCoHggfD0geCAmZ3Q7Jmd0OyA4Ozxicj4NCivCoCDCoCDCoCDC
oHggfD0geCAmZ3Q7Jmd0OyAxNjs8YnI+DQorwqAgwqAgwqAgwqB4Kys7PGJyPg0KK8KgIMKgIMKg
IMKgaWYgKHggPT0gc2F2ZWQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHg7
PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHggJmd0OyZndDsgMTs8YnI+DQrCoH08YnI+DQo8YnI+
DQrCoHN0YXRpYyB2b2lkPGJyPg0KQEAgLTczNCw2ICs3NjMsOSBAQCBhcmdzX3BhcnNlKGludCBh
cmdjLCBjaGFyICoqYXJndik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7ICZxdW90O3Bv
bGljeS1tdHImcXVvdDsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxLCAwLCAwIH0sPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgeyAmcXVvdDttZXRlci1wcm9maWxlJnF1b3Q7LMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDEsIDAsIDAgfSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7
ICZxdW90O3BhY2tldC1tb2RlJnF1b3Q7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDAsIDAsIDAg
fSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7ICZxdW90O2FzeW5jJnF1b3Q7LMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDAsIDAsIDAgfSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB7ICZxdW90O2FzeW5jLXF1ZXVlLXNpemUmcXVvdDsswqAgwqAgwqAgwqAgwqAg
wqAxLCAwLCAwIH0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgeyAmcXVvdDthc3luYy1w
dXNoLWJhdGNoJnF1b3Q7LMKgIMKgIMKgIMKgIMKgIMKgMSwgMCwgMCB9LDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHsgMCwgMCwgMCwgMCB9LDxicj4NCsKgIMKgIMKgIMKgIH07PGJyPg0K
PGJyPg0KQEAgLTkxMyw4ICs5NDUsNyBAQCBhcmdzX3BhcnNlKGludCBhcmdjLCBjaGFyICoqYXJn
dik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBydGVfZXhpdChFWElUX0ZBSUxVUkUsICZxdW90O0ludmFsaWQgaGFpcnBpbiBj
b25maWcgbWFza1xuJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBoYWlycGluX2NvbmZfbWFzayA9IGhwX2NvbmY7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChzdHJjbXAobGdvcHRzW29wdF9pZHhdLm5hbWUsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JnF1b3Q7cG9ydC1pZCZxdW90OykgPT0gMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChzdHJjbXAobGdvcHRzW29wdF9pZHhdLm5hbWUsICZxdW90O3BvcnQt
aWQmcXVvdDspID09IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB1aW50MTZfdCBwb3J0X2lkeCA9IDA7PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdG9rZW4gPSBzdHJ0b2sob3B0
YXJnLCAmcXVvdDssJnF1b3Q7KTs8YnI+DQpAQCAtOTgxLDYgKzEwMTIsMjYgQEAgYXJnc19wYXJz
ZShpbnQgYXJnYywgY2hhciAqKmFyZ3YpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChz
dHJjbXAobGdvcHRzW29wdF9pZHhdLm5hbWUsICZxdW90O3BhY2tldC1tb2RlJnF1b3Q7KSA9PSAw
KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBh
Y2tldF9tb2RlID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoc3RyY21wKGxnb3B0c1tvcHRfaWR4XS5uYW1lLCAmcXVvdDthc3luYyZxdW90OykgPT0g
MCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBh
c3luY19tb2RlID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoc3RyY21wKGxnb3B0c1tvcHRfaWR4XS5uYW1lLCAmcXVvdDthc3luYy1xdWV1ZS1zaXpl
JnF1b3Q7KSA9PSAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgbiA9IGF0b2kob3B0YXJnKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobiAmZ3Q7PSBNQVhfQVNZTkNfUVVFVUVfU0la
RSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBhc3luY19xdWV1ZV9zaXplID0gTUFYX0FTWU5DX1FVRVVFX1NJWkU7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZSBpZiAo
biAmZ3Q7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgYXN5bmNfcXVldWVfc2l6ZSA9IHByZXZfcG93ZXJfb2ZfdHdvKG4p
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVs
c2U8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBydGVfZXhpdChFWElUX0ZBSUxVUkUsICZxdW90O2FzeW5jLXF1ZXVlLXNpemUg
c2hvdWxkIGJlICZndDsgMFxuJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KHN0cmNtcChsZ29wdHNbb3B0X2lkeF0ubmFtZSwgJnF1b3Q7YXN5bmMtcHVzaC1iYXRjaCZxdW90
OykgPT0gMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG4gPSBhdG9pKG9wdGFyZyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG4gJmd0Oz0gTUFYX0FTWU5DX1FVRVVFX1NJWkUgJmd0
OyZndDsgMSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBhc3luY19wdXNoX2JhdGNoID0gTUFYX0FTWU5DX1FVRVVFX1NJWkUg
Jmd0OyZndDsgMTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBlbHNlIGlmIChuICZndDsgMCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhc3luY19wdXNoX2JhdGNoID0gcHJl
dl9wb3dlcl9vZl90d28obik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZWxzZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9leGl0KEVYSVRfRkFJTFVSRSwgJnF1b3Q7
YXN5bmMtcHVzaC1iYXRjaCBzaG91bGQgYmUgJmd0OyAwXG4mcXVvdDspOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBicmVhazs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZWZhdWx0
Ojxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVzYWdlKGFyZ3ZbMF0p
Ozxicj4NCkBAIC0xNDU3LDEwICsxNTA4LDEwIEBAIHF1ZXJ5X2Zsb3dzKGludCBwb3J0X2lkLCB1
aW50OF90IGNvcmVfaWQsIHN0cnVjdCBydGVfZmxvdyAqKmZsb3dzX2xpc3QpPGJyPg0KwqAgwqAg
wqAgwqAgbWNfcG9vbC5mbG93c19yZWNvcmQucXVlcnlbcG9ydF9pZF1bY29yZV9pZF0gPSBjcHVf
dGltZV91c2VkOzxicj4NCsKgfTxicj4NCjxicj4NCi1zdGF0aWMgc3RydWN0IHJ0ZV9mbG93ICoq
PGJyPg0KLWluc2VydF9mbG93cyhpbnQgcG9ydF9pZCwgdWludDhfdCBjb3JlX2lkLCB1aW50MTZf
dCBkc3RfcG9ydF9pZCk8YnI+DQorc3RhdGljIHZvaWQ8YnI+DQoraW5zZXJ0X2Zsb3dzKGludCBw
b3J0X2lkLCB1aW50OF90IGNvcmVfaWQsIHVpbnQxNl90IGRzdF9wb3J0X2lkLCBzdHJ1Y3QgcnRl
X2Zsb3cgKipmbG93c19saXN0KTxicj4NCsKgezxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBydGVf
ZmxvdyAqKmZsb3dzX2xpc3Q7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHJ0ZV9mbG93ICpmbG93
Ozxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBydGVfZmxvd19lcnJvciBlcnJvcjs8YnI+DQrCoCDC
oCDCoCDCoCBjbG9ja190IHN0YXJ0X2JhdGNoLCBlbmRfYmF0Y2g7PGJyPg0KwqAgwqAgwqAgwqAg
ZG91YmxlIGZpcnN0X2Zsb3dfbGF0ZW5jeTs8YnI+DQpAQCAtMTQ4NSw4ICsxNTM2LDcgQEAgaW5z
ZXJ0X2Zsb3dzKGludCBwb3J0X2lkLCB1aW50OF90IGNvcmVfaWQsIHVpbnQxNl90IGRzdF9wb3J0
X2lkKTxicj4NCsKgIMKgIMKgIMKgIGdsb2JhbF9pdGVtc1swXSA9IEZMT1dfSVRFTV9NQVNLKFJU
RV9GTE9XX0lURU1fVFlQRV9FVEgpOzxicj4NCsKgIMKgIMKgIMKgIGdsb2JhbF9hY3Rpb25zWzBd
ID0gRkxPV19JVEVNX01BU0soUlRFX0ZMT1dfQUNUSU9OX1RZUEVfSlVNUCk7PGJyPg0KPGJyPg0K
LcKgIMKgIMKgIMKgZmxvd3NfbGlzdCA9IHJ0ZV96bWFsbG9jKCZxdW90O2Zsb3dzX2xpc3QmcXVv
dDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHNpemVvZihzdHJ1Y3QgcnRlX2Zsb3cg
KikgKiAocnVsZXNfY291bnRfcGVyX2NvcmUgKyAxKSksIDApOzxicj4NCivCoCDCoCDCoCDCoGZs
b3dzX2xpc3QgPSBtYWxsb2Moc2l6ZW9mKHN0cnVjdCBydGVfZmxvdyAqKSAqIChydWxlc19jb3Vu
dF9wZXJfY29yZSArIDEpKTs8YnI+DQrCoCDCoCDCoCDCoCBpZiAoZmxvd3NfbGlzdCA9PSBOVUxM
KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJ0ZV9leGl0KEVYSVRfRkFJTFVSRSwgJnF1
b3Q7Tm8gTWVtb3J5IGF2YWlsYWJsZSFcbiZxdW90Oyk7PGJyPg0KPGJyPg0KQEAgLTE1MjQsNiAr
MTU3NCwxMSBAQCBpbnNlcnRfZmxvd3MoaW50IHBvcnRfaWQsIHVpbnQ4X3QgY29yZV9pZCwgdWlu
dDE2X3QgZHN0X3BvcnRfaWQpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgY29yZV9pZCwgcnhfcXVldWVzX2NvdW50LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHVuaXF1ZV9kYXRhLCBtYXhfcHJpb3JpdHksICZhbXA7ZXJyb3IpOzxicj4N
Cjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghZmxvdykgezxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50X2Zsb3dfZXJyb3IoZXJyb3IpOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9leGl0KEVYSVRfRkFJTFVS
RSwgJnF1b3Q7RXJyb3IgaW4gY3JlYXRpbmcgZmxvd1xuJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICgh
Y291bnRlcikgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZpcnN0
X2Zsb3dfbGF0ZW5jeSA9IChkb3VibGUpIChydGVfZ2V0X3RpbWVyX2N5Y2xlcygpIC0gc3RhcnRf
YmF0Y2gpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZpcnN0X2Zs
b3dfbGF0ZW5jeSAvPSBydGVfZ2V0X3RpbWVyX2h6KCk7PGJyPg0KQEAgLTE1MzcsMTEgKzE1OTIs
NiBAQCBpbnNlcnRfZmxvd3MoaW50IHBvcnRfaWQsIHVpbnQ4X3QgY29yZV9pZCwgdWludDE2X3Qg
ZHN0X3BvcnRfaWQpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGZvcmNlX3F1aXQp
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY291bnRlciA9IGVuZF9j
b3VudGVyOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghZmxvdykgezxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50X2Zsb3dfZXJyb3Io
ZXJyb3IpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9leGl0
KEVYSVRfRkFJTFVSRSwgJnF1b3Q7RXJyb3IgaW4gY3JlYXRpbmcgZmxvd1xuJnF1b3Q7KTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KLTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGZsb3dzX2xpc3RbZmxvd19pbmRleCsrXSA9IGZsb3c7PGJyPg0KPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgLyo8YnI+DQpAQCAtMTU3NSw3ICsxNjI1LDIwMyBAQCBpbnNlcnRf
Zmxvd3MoaW50IHBvcnRfaWQsIHVpbnQ4X3QgY29yZV9pZCwgdWludDE2X3QgZHN0X3BvcnRfaWQp
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcG9ydF9pZCwgY29yZV9pZCwgcnVsZXNfY291
bnRfcGVyX2NvcmUsIGNwdV90aW1lX3VzZWQpOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIG1jX3Bv
b2wuZmxvd3NfcmVjb3JkLmluc2VydGlvbltwb3J0X2lkXVtjb3JlX2lkXSA9IGNwdV90aW1lX3Vz
ZWQ7PGJyPg0KLcKgIMKgIMKgIMKgcmV0dXJuIGZsb3dzX2xpc3Q7PGJyPg0KK308YnI+DQorPGJy
Pg0KK3N0YXRpYyB1aW50MzJfdCBwdXNoX2NvdW50ZXJbUlRFX01BWF9MQ09SRV07PGJyPg0KKzxi
cj4NCitzdGF0aWMgaW5saW5lIGludDxicj4NCitwdXNoX3B1bGxfZmxvd3NfYXN5bmMoaW50IHBv
cnRfaWQsIGludCBxdWV1ZV9pZCwgaW50IGNvcmVfaWQsIHVpbnQzMl90IGVucXVldWVkLCBib29s
IGVtcHR5LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJvb2wgY2hlY2tf
b3Bfc3RhdHVzLCBzdHJ1Y3QgcnRlX2Zsb3dfZXJyb3IgKmVycm9yKTxicj4NCit7PGJyPg0KK8Kg
IMKgIMKgIMKgc3RhdGljIHN0cnVjdCBydGVfZmxvd19vcF9yZXN1bHQgcmVzdWx0c1tSVEVfTUFY
X0xDT1JFXVtNQVhfQVNZTkNfUVVFVUVfU0laRV07PGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3Qg
dG9fcHVsbCA9IChlbXB0eSB8fCBhc3luY19wdXNoX2JhdGNoICZndDsgZW5xdWV1ZWQpID8gZW5x
dWV1ZWQgOiBhc3luY19wdXNoX2JhdGNoOzxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IHB1bGxl
ZF9jb21wbGV0ZSA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgcmV0cmllcyA9IDA7PGJy
Pg0KK8KgIMKgIMKgIMKgaW50IHB1bGxlZCwgaTs8YnI+DQorwqAgwqAgwqAgwqBpbnQgcmV0ID0g
MDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogUHVzaCBwZXJpb2RpY2FsbHkgdG8gZ2l2ZSBI
VyB3b3JrIHRvIGRvICovPGJyPg0KK8KgIMKgIMKgIMKgcmV0ID0gcnRlX2Zsb3dfcHVzaChwb3J0
X2lkLCBxdWV1ZV9pZCwgZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoGlmIChyZXQpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQorwqAgwqAgwqAgwqBwdXNoX2Nv
dW50ZXJbY29yZV9pZF0rKzs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogQ2hlY2sgaWYgcXVl
dWUgaXMgZ2V0dGluZyBmdWxsLCBpZiBzbyBwdXNoIGFuZCBkcmFpbiBjb21wbGV0aW9ucyAqLzxi
cj4NCivCoCDCoCDCoCDCoGlmICghZW1wdHkgJmFtcDsmYW1wOyBwdXNoX2NvdW50ZXJbY29yZV9p
ZF0gPT0gMSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgd2hpbGUgKHRvX3B1bGwgJmd0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcHVsbGVkID0gcnRlX2Zsb3dfcHVsbChwb3J0X2lkLCBxdWV1ZV9pZCwgcmVz
dWx0c1tjb3JlX2lkXSwgdG9fcHVsbCwgZXJyb3IpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChwdWxsZWQgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSBp
ZiAocHVsbGVkID09IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoKytyZXRyaWVzICZndDsgTUFYX1BVTExfUkVUUklFUykgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9mbG93X2Vycm9yX3NldChl
cnJvciwgRVRJTUVET1VULDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSVEVfRkxPV19FUlJPUl9U
WVBFX1VOU1BFQ0lGSUVELCBOVUxMLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtUaW1l
b3V0IHdhaXRpbmcgZm9yIGFzeW5jIGNvbXBsZXRpb25zJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9wYXVzZSgpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNvbnRpbnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXRyaWVzID0gMDs8YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdG9fcHVsbCAtPSBwdWxsZWQ7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcHVsbGVkX2NvbXBsZXRlICs9IHB1bGxlZDs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiAoIWNoZWNrX29wX3N0YXR1cyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IHB1bGxlZDsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlc3VsdHNbY29yZV9pZF1baV0uc3RhdHVzICE9
IFJURV9GTE9XX09QX1NVQ0NFU1MpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfZmxvd19lcnJvcl9zZXQoZXJyb3IsIEVJTlZBTCwgUlRF
X0ZMT1dfRVJST1JfVFlQRV9VTlNQRUNJRklFRCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTlVM
TCwgJnF1b3Q7U29tZSBmbG93IHJ1bGUgaW5zZXJ0aW9uIGZhaWxlZCZxdW90Oyk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqByZXR1cm4gcHVsbGVkX2NvbXBsZXRlOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgdm9p
ZDxicj4NCitpbnNlcnRfZmxvd3NfYXN5bmMoaW50IHBvcnRfaWQsIHVpbnQ4X3QgY29yZV9pZCwg
dWludDE2X3QgZHN0X3BvcnRfaWQsIHN0cnVjdCBydGVfZmxvdyAqKmZsb3dzX2xpc3QpPGJyPg0K
K3s8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgcnRlX2Zsb3cgKmZsb3c7PGJyPg0KK8KgIMKgIMKg
IMKgc3RydWN0IHJ0ZV9mbG93X2Vycm9yIGVycm9yOzxicj4NCivCoCDCoCDCoCDCoGNsb2NrX3Qg
c3RhcnRfYmF0Y2gsIGVuZF9iYXRjaDs8YnI+DQorwqAgwqAgwqAgwqBkb3VibGUgZmlyc3RfZmxv
d19sYXRlbmN5Ozxicj4NCivCoCDCoCDCoCDCoGRvdWJsZSBjcHVfdGltZV91c2VkOzxicj4NCivC
oCDCoCDCoCDCoGRvdWJsZSBpbnNlcnRpb25fcmF0ZTs8YnI+DQorwqAgwqAgwqAgwqBkb3VibGUg
Y3B1X3RpbWVfcGVyX2JhdGNoW01BWF9CQVRDSEVTX0NPVU5UXSA9IHswfTs8YnI+DQorwqAgwqAg
wqAgwqBkb3VibGUgZGVsdGE7PGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgZmxvd19pbmRleDs8
YnI+DQorwqAgwqAgwqAgwqB1aW50MzJfdCBjb3VudGVyLCBiYXRjaF9jb3VudGVyLCBzdGFydF9j
b3VudGVyID0gMCwgZW5kX2NvdW50ZXI7PGJyPg0KK8KgIMKgIMKgIMKgaW50IHJ1bGVzX2JhdGNo
X2lkeDs8YnI+DQorwqAgwqAgwqAgwqBpbnQgcnVsZXNfY291bnRfcGVyX2NvcmU7PGJyPg0KK8Kg
IMKgIMKgIMKgdWludDMyX3QgZW5xdWV1ZWQgPSAwOzxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90
IHF1ZXVlX2lkID0gY29yZV9pZDs8YnI+DQorwqAgwqAgwqAgwqBib29sIGZpcnN0X2JhdGNoID0g
dHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqBpbnQgcHVsbGVkOzxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqBydWxlc19jb3VudF9wZXJfY29yZSA9IHJ1bGVzX2NvdW50IC8gbWNfcG9vbC5jb3Jlc19jb3Vu
dDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGFzeW5jX3B1c2hfYmF0Y2ggJmd0OyBhc3lu
Y19xdWV1ZV9zaXplICZndDsmZ3Q7IDEpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYXN5
bmNfcHVzaF9iYXRjaCA9IGFzeW5jX3F1ZXVlX3NpemUgJmd0OyZndDsgMTs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgLyogU2V0IGJvdW5kYXJpZXMgb2YgcnVsZXMgZm9yIGVhY2ggY29yZS4gKi88
YnI+DQorwqAgwqAgwqAgwqBpZiAoY29yZV9pZCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdGFydF9jb3VudGVyID0gY29yZV9pZCAqIHJ1bGVzX2NvdW50X3Blcl9jb3JlOzxicj4NCivC
oCDCoCDCoCDCoGVuZF9jb3VudGVyID0gKGNvcmVfaWQgKyAxKSAqIHJ1bGVzX2NvdW50X3Blcl9j
b3JlOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBjcHVfdGltZV91c2VkID0gMDs8YnI+DQorwqAg
wqAgwqAgwqBmbG93X2luZGV4ID0gMDs8YnI+DQorwqAgwqAgwqAgwqBwdXNoX2NvdW50ZXJbY29y
ZV9pZF0gPSAwOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoZmxvd19ncm91cCAmZ3Q7IDAg
JmFtcDsmYW1wOyBjb3JlX2lkID09IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAv
Kjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIENyZWF0ZSBnbG9iYWwgcnVsZSB0byBq
dW1wIGludG8gZmxvd19ncm91cCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB0aGlz
IHdheSB0aGUgYXBwIHdpbGwgYXZvaWQgdGhlIGRlZmF1bHQgcnVsZXMuPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBUaGlzIHJ1
bGUgd2lsbCBiZSBjcmVhdGVkIG9ubHkgb25jZS48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIEdsb2JhbCBydWxlOjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGdyb3VwIDAgZXRoIC8gZW5kIGFjdGlvbnMganVtcCBn
cm91cCAmbHQ7Zmxvd19ncm91cCZndDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDY0X3QgZ2xvYmFsX2l0ZW1z
W01BWF9JVEVNU19OVU1dID0gezB9Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ2
NF90IGdsb2JhbF9hY3Rpb25zW01BWF9BQ1RJT05TX05VTV0gPSB7MH07PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZ2xvYmFsX2l0ZW1zWzBdID0gRkxPV19JVEVNX01BU0soUlRFX0ZMT1df
SVRFTV9UWVBFX0VUSCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ2xvYmFsX2FjdGlv
bnNbMF0gPSBGTE9XX0lURU1fTUFTSyhSVEVfRkxPV19BQ1RJT05fVFlQRV9KVU1QKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmbG93ID0gZ2VuZXJhdGVfZmxvdyhwb3J0X2lkLCAwLCBm
bG93X2F0dHJzLCBnbG9iYWxfaXRlbXMsIGdsb2JhbF9hY3Rpb25zLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmbG93X2dyb3VwLCAw
LCAwLCAwLCAwLCBkc3RfcG9ydF9pZCwgY29yZV9pZCwgcnhfcXVldWVzX2NvdW50LDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1bmlx
dWVfZGF0YSwgbWF4X3ByaW9yaXR5LCAmYW1wO2Vycm9yKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKGZsb3cgPT0gTlVMTCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHByaW50X2Zsb3dfZXJyb3IoZXJyb3IpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9leGl0KEVYSVRfRkFJTFVSRSwgJnF1b3Q7
RXJyb3IgaW4gY3JlYXRpbmcgZmxvd1xuJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmxvd3NfbGlzdFtmbG93X2luZGV4
KytdID0gZmxvdzs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHN0
YXJ0X2JhdGNoID0gcnRlX2dldF90aW1lcl9jeWNsZXMoKTs8YnI+DQorwqAgwqAgwqAgwqBmb3Ig
KGNvdW50ZXIgPSBzdGFydF9jb3VudGVyOyBjb3VudGVyICZsdDsgZW5kX2NvdW50ZXI7KSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogYmF0Y2ggYWRkaW5nIGZsb3cgcnVsZXMsIHRo
aXMgYXZvaWRzIHVubmVjZXNzYXJ5IGNoZWNrcyBmb3IgcHVzaC9wdWxsICovPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZm9yIChiYXRjaF9jb3VudGVyID0gMDsgYmF0Y2hfY291bnRlciAm
bHQ7IGFzeW5jX3B1c2hfYmF0Y2ggJmFtcDsmYW1wOyBjb3VudGVyICZsdDsgZW5kX2NvdW50ZXI7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJhdGNoX2NvdW50ZXIrKywgY291
bnRlcisrKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogQ3Jl
YXRlIGZsb3cgd2l0aCBwb3N0cG9uZT10cnVlIHRvIGJhdGNoIG9wZXJhdGlvbnMgKi88YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmbG93ID0gYXN5bmNfZ2VuZXJhdGVf
Zmxvdyhwb3J0X2lkLCBxdWV1ZV9pZCwgY291bnRlciwgaGFpcnBpbl9xdWV1ZXNfbnVtLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBlbmNhcF9kYXRhLCBkZWNhcF9kYXRhLCBkc3RfcG9ydF9pZCwg
Y29yZV9pZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcnhfcXVldWVzX2NvdW50LCB1bmlxdWVf
ZGF0YSwgdHJ1ZSwgJmFtcDtlcnJvcik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmICghZmxvdykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50X2Zsb3dfZXJyb3IoZXJyb3IpOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9leGl0KEVY
SVRfRkFJTFVSRSwgJnF1b3Q7RXJyb3IgaW4gY3JlYXRpbmcgYXN5bmMgZmxvd1xuJnF1b3Q7KTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChmb3JjZV9xdWl0KTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmbG93c19saXN0W2Zs
b3dfaW5kZXgrK10gPSBmbG93Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGVucXVldWVkKys7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC8qPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogU2F2
ZSB0aGUgaW5zZXJ0aW9uIHJhdGUgZm9yIHJ1bGVzIGJhdGNoLjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIENoZWNrIGlmIHRoZSBpbnNlcnRpb24gcmVhY2hlZCB0
aGUgcnVsZXM8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBwYXRj
aCBjb3VudGVyLCB0aGVuIHNhdmUgdGhlIGluc2VydGlvbiByYXRlPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogZm9yIHRoaXMgYmF0Y2guPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKCEoKGNvdW50ZXIgKyAxKSAlIHJ1bGVzX2JhdGNoKSkgezxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVuZF9iYXRj
aCA9IHJ0ZV9nZXRfdGltZXJfY3ljbGVzKCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVsdGEgPSAoZG91YmxlKShlbmRfYmF0Y2ggLSBzdGFy
dF9iYXRjaCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcnVsZXNfYmF0Y2hfaWR4ID0gKChjb3VudGVyICsgMSkgLyBydWxlc19iYXRjaCkgLSAx
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNw
dV90aW1lX3Blcl9iYXRjaFtydWxlc19iYXRjaF9pZHhdID0gZGVsdGEgLyBydGVfZ2V0X3RpbWVy
X2h6KCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY3B1X3RpbWVfdXNlZCArPSBjcHVfdGltZV9wZXJfYmF0Y2hbcnVsZXNfYmF0Y2hfaWR4XTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdGFy
dF9iYXRjaCA9IHJ0ZV9nZXRfdGltZXJfY3ljbGVzKCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKChwdWxsZWQgPSBwdXNoX3B1bGxfZmxv
d3NfYXN5bmMocG9ydF9pZCwgcXVldWVfaWQsIGNvcmVfaWQsIGVucXVldWVkLCBmYWxzZSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0cnVlLCAmYW1wO2Vycm9yKSkgJmx0OyAwKSB7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJpbnRfZmxvd19lcnJvcihlcnJv
cik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2V4aXQoRVhJ
VF9GQUlMVVJFLCAmcXVvdDtFcnJvciBwdXNoL3B1bGwgYXN5bmMgb3BlcmF0aW9uc1xuJnF1b3Q7
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGVucXVldWVkIC09IHB1bGxlZDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKGZpcnN0X2JhdGNoKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZmlyc3RfZmxvd19sYXRlbmN5ID0gKGRvdWJsZSkocnRlX2dldF90aW1l
cl9jeWNsZXMoKSAtIHN0YXJ0X2JhdGNoKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBmaXJzdF9mbG93X2xhdGVuY3kgLz0gcnRlX2dldF90aW1lcl9oeigpOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIEluIG1pbGxpc2Vjb25kICov
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmlyc3RfZmxvd19sYXRl
bmN5ICo9IDEwMDA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJp
bnRmKCZxdW90Ozo6IEZpcnN0IEZsb3cgQmF0Y2ggTGF0ZW5jeSAoQXN5bmMpIDo6IFBvcnQgJWQg
OjogRmlyc3QgYmF0Y2ggKCV1KSAmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7aW5zdGFsbGVkIGluICVmIG1pbGxpc2Vjb25kc1xu
JnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBwb3J0X2lkLCBhc3luY19wdXNoX2JhdGNoLCBmaXJzdF9mbG93X2xhdGVuY3kpOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZpcnN0X2JhdGNoID0gZmFsc2U7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgaWYgKHB1c2hfcHVsbF9mbG93c19hc3luYyhwb3J0X2lkLCBxdWV1ZV9p
ZCwgY29yZV9pZCwgZW5xdWV1ZWQsIHRydWUsIHRydWUsICZhbXA7ZXJyb3IpICZsdDsgMCkgezxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50X2Zsb3dfZXJyb3IoZXJyb3IpOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9leGl0KEVYSVRfRkFJTFVSRSwgJnF1b3Q7RXJy
b3IgZmluYWwgcHVzaC9wdWxsIGFzeW5jIG9wZXJhdGlvbnNcbiZxdW90Oyk7PGJyPg0KK8KgIMKg
IMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBQcmludCBpbnNlcnRpb24gcmF0ZXMg
Zm9yIGFsbCBiYXRjaGVzICovPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGR1bXBfaXRlcmF0aW9ucyk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwcmludF9ydWxlc19iYXRjaGVzKGNwdV90aW1l
X3Blcl9iYXRjaCk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHByaW50ZigmcXVvdDs6OiBQb3J0
ICVkIDo6IENvcmUgJWQgYm91bmRhcmllcyAoQXN5bmMpIDo6IHN0YXJ0IEBbJWRdIC0gZW5kIEBb
JWRdXG4mcXVvdDssIHBvcnRfaWQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIGNvcmVfaWQs
IHN0YXJ0X2NvdW50ZXIsIGVuZF9jb3VudGVyIC0gMSk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oC8qIEluc2VydGlvbiByYXRlIGZvciBhbGwgcnVsZXMgaW4gb25lIGNvcmUgKi88YnI+DQorwqAg
wqAgwqAgwqBpZiAoY3B1X3RpbWVfdXNlZCAmZ3Q7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpbnNlcnRpb25fcmF0ZSA9ICgoZG91YmxlKXJ1bGVzX2NvdW50X3Blcl9jb3JlIC8g
Y3B1X3RpbWVfdXNlZCkgLyAxMDAwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByaW50
ZigmcXVvdDs6OiBQb3J0ICVkIDo6IENvcmUgJWQgOjogQXN5bmMgcnVsZXMgaW5zZXJ0aW9uIHJh
dGUgLSZndDsgJWYgSyBSdWxlL1NlY1xuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBwb3J0X2lkLCBjb3JlX2lkLCBpbnNlcnRpb25fcmF0ZSk7PGJyPg0KK8Kg
IMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoHByaW50ZigmcXVvdDs6OiBQb3J0ICVkIDo6IENv
cmUgJWQgOjogVGhlIHRpbWUgZm9yIGNyZWF0aW5nICVkIGFzeW5jIHJ1bGVzIGlzICVmIHNlY29u
ZHNcbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgcG9ydF9pZCwgY29yZV9pZCwg
cnVsZXNfY291bnRfcGVyX2NvcmUsIGNwdV90aW1lX3VzZWQpOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBtY19wb29sLmZsb3dzX3JlY29yZC5pbnNlcnRpb25bcG9ydF9pZF1bY29yZV9pZF0gPSBj
cHVfdGltZV91c2VkOzxicj4NCsKgfTxicj4NCjxicj4NCsKgc3RhdGljIHZvaWQ8YnI+DQpAQCAt
MTU4NSwxMiArMTgzMSwxOCBAQCBmbG93c19oYW5kbGVyKHVpbnQ4X3QgY29yZV9pZCk8YnI+DQrC
oCDCoCDCoCDCoCB1aW50MTZfdCBwb3J0X2lkeCA9IDA7PGJyPg0KwqAgwqAgwqAgwqAgdWludDE2
X3QgbnJfcG9ydHM7PGJyPg0KwqAgwqAgwqAgwqAgaW50IHBvcnRfaWQ7PGJyPg0KK8KgIMKgIMKg
IMKgaW50IHJ1bGVzX2NvdW50X3Blcl9jb3JlOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIG5yX3Bv
cnRzID0gcnRlX2V0aF9kZXZfY291bnRfYXZhaWwoKTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBp
ZiAocnVsZXNfYmF0Y2ggJmd0OyBydWxlc19jb3VudCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBydWxlc19iYXRjaCA9IHJ1bGVzX2NvdW50Ozxicj4NCjxicj4NCivCoCDCoCDCoCDCoHJ1
bGVzX2NvdW50X3Blcl9jb3JlID0gcnVsZXNfY291bnQgLyBtY19wb29sLmNvcmVzX2NvdW50Ozxi
cj4NCivCoCDCoCDCoCDCoGZsb3dzX2xpc3QgPSBtYWxsb2Moc2l6ZW9mKHN0cnVjdCBydGVfZmxv
dyAqKSAqIChydWxlc19jb3VudF9wZXJfY29yZSArIDEpKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAo
Zmxvd3NfbGlzdCA9PSBOVUxMKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9leGl0
KEVYSVRfRkFJTFVSRSwgJnF1b3Q7Tm8gTWVtb3J5IGF2YWlsYWJsZSFcbiZxdW90Oyk7PGJyPg0K
Kzxicj4NCsKgIMKgIMKgIMKgIHByaW50ZigmcXVvdDs6OiBSdWxlcyBDb3VudCBwZXIgcG9ydDog
JWRcblxuJnF1b3Q7LCBydWxlc19jb3VudCk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgZm9yIChw
b3J0X2lkID0gMDsgcG9ydF9pZCAmbHQ7IG5yX3BvcnRzOyBwb3J0X2lkKyspIHs8YnI+DQpAQCAt
MTYwMiwxMCArMTg1NCwxMCBAQCBmbG93c19oYW5kbGVyKHVpbnQ4X3QgY29yZV9pZCk8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtY19wb29sLmxhc3RfYWxsb2NbY29yZV9pZF0gPSAoaW50
NjRfdClkdW1wX3NvY2tldF9tZW0oc3Rkb3V0KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAoaGFzX21ldGVyKCkpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgbWV0ZXJzX2hhbmRsZXIocG9ydF9pZCwgY29yZV9pZCwgTUVURVJfQ1JFQVRFKTs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmbG93c19saXN0ID0gaW5zZXJ0X2Zsb3dzKHBvcnRfaWQs
IGNvcmVfaWQsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZHN0X3BvcnRzW3BvcnRfaWR4KytdKTs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZmxvd3NfbGlzdCA9PSBOVUxMKTxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9leGl0KEVYSVRfRkFJTFVSRSwg
JnF1b3Q7RXJyb3I6IEluc2VydGlvbiBGYWlsZWQhXG4mcXVvdDspOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChhc3luY19tb2RlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGluc2VydF9mbG93c19hc3luYyhwb3J0X2lkLCBjb3JlX2lkLCBkc3RfcG9y
dHNbcG9ydF9pZHgrK10sIGZsb3dzX2xpc3QpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGVsc2U8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnNlcnRfZmxv
d3MocG9ydF9pZCwgY29yZV9pZCwgZHN0X3BvcnRzW3BvcnRfaWR4KytdLCBmbG93c19saXN0KTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtY19wb29sLmN1cnJlbnRfYWxsb2NbY29yZV9p
ZF0gPSAoaW50NjRfdClkdW1wX3NvY2tldF9tZW0oc3Rkb3V0KTs8YnI+DQo8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBpZiAocXVlcnlfZmxhZyk8YnI+DQpAQCAtMjIxMiw2ICsyNDY0LDE2
IEBAIGluaXRfcG9ydCh2b2lkKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLyogQ29uZmlndXJlIGFzeW5jIGZsb3cgZW5naW5lIGJlZm9yZSBkZXZp
Y2Ugc3RhcnQgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoYXN5bmNfbW9kZSkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IGFzeW5jX2Zs
b3dfaW5pdF9wb3J0KHBvcnRfaWQsIG1jX3Bvb2wuY29yZXNfY291bnQsIGFzeW5jX3F1ZXVlX3Np
emUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZsb3dfaXRlbXMsIGZsb3dfYWN0aW9ucywgZmxv
d19hdHRycywgZmxvd19ncm91cCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcnVsZXNfY291bnQp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQgIT0gMCk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVf
ZXhpdChFWElUX0ZBSUxVUkUsICZxdW90O0ZhaWxlZCB0byBpbml0IGFzeW5jIGZsb3cgb24gcG9y
dCAlZFxuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwb3J0X2lkKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9PGJyPg0KKzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldCA9IHJ0ZV9ldGhf
ZGV2X3N0YXJ0KHBvcnRfaWQpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChyZXQg
Jmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJ0ZV9leGl0
KEVYSVRfRkFJTFVSRSw8YnI+DQpAQCAtMjI5MSw2ICsyNTUzLDggQEAgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgUlRFX0VUSF9GT1JFQUNIX0RFVihw
b3J0KSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcnRlX2Zsb3dfZmx1c2gocG9ydCwg
JmFtcDtlcnJvcik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGFzeW5jX21vZGUp
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYXN5bmNfZmxvd19jbGVh
bnVwX3BvcnQocG9ydCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJ0ZV9ldGhf
ZGV2X3N0b3AocG9ydCkgIT0gMCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBwcmludGYoJnF1b3Q7RmFpbGVkIHRvIHN0b3AgZGV2aWNlIG9uIHBvcnQgJXVcbiZxdW90
OywgcG9ydCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcnRlX2V0aF9kZXZfY2xvc2Uo
cG9ydCk7PGJyPg0KZGlmZiAtLWdpdCBhL2FwcC90ZXN0LWZsb3ctcGVyZi9tZXNvbi5idWlsZCBi
L2FwcC90ZXN0LWZsb3ctcGVyZi9tZXNvbi5idWlsZDxicj4NCmluZGV4IGUxMDE0NDllMzIuLjJm
ODIwYTc1OTcgMTAwNjQ0PGJyPg0KLS0tIGEvYXBwL3Rlc3QtZmxvdy1wZXJmL21lc29uLmJ1aWxk
PGJyPg0KKysrIGIvYXBwL3Rlc3QtZmxvdy1wZXJmL21lc29uLmJ1aWxkPGJyPg0KQEAgLTMsNiAr
Myw3IEBAPGJyPg0KPGJyPg0KwqBzb3VyY2VzID0gZmlsZXMoPGJyPg0KwqAgwqAgwqAgwqAgwqAm
IzM5O2FjdGlvbnNfZ2VuLmMmIzM5Oyw8YnI+DQorwqAgwqAgwqAgwqAgJiMzOTthc3luY19mbG93
LmMmIzM5Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCYjMzk7Zmxvd19nZW4uYyYjMzk7LDxicj4NCsKg
IMKgIMKgIMKgIMKgJiMzOTtpdGVtc19nZW4uYyYjMzk7LDxicj4NCsKgIMKgIMKgIMKgIMKgJiMz
OTttYWluLmMmIzM5Oyw8YnI+DQotLSA8YnI+DQoyLjQzLjA8YnI+DQo8YnI+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+DQo=
--0000000000001117a8064bfef186--
