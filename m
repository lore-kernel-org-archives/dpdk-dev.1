Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E829606A880
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=OsH9bA0x
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1134540297;
	Wed, 11 Nov 2026 13:56:52 +0100 (CET)
Received: from forward501e.mail.yandex.net (forward501e.mail.yandex.net
 [93.77.172.86])
 by mails.dpdk.org (Postfix) with ESMTPS id 14A564026A;
 Wed, 11 Nov 2026 13:56:51 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-93
 (mail-nwsmtp-smtp-production-main-93.yp-c.yandex.net)
 by forward501e.mail.yandex.net (postfix) with ESMTPS id F2DBCC0099;
 Wed, 11 Nov 2026 15:56:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-93 with ESMTPSA id
 kuS8plNF0Cg0-yUyvHACl; Wed, 11 Nov 2026 15:56:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1794401808; bh=lhje2XzrNjOA0Q570EfT+d27e03w+fxi/Ejl6frlV4s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=OsH9bA0xsWFVOHTif25pSoUJ1xJSpn8loWDBsxpWiDcT+bogb5FY1zF2J7r6RszLJ
 QJsywBxYSh7QLNQt1Ni1LXJv1/KyIc+2h3WpOvyv2n11ncZD0+7C16xzaHb2ZLJh/T
 f9+AIHi2uYthkrqOk0UnPFUh7n1C+UIopVNOsK0Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-93;
 dkim=pass header.i=@yandex.ru
Message-ID: <f350e15d-2040-4a99-b7a0-1c3391cedecc@yandex.ru>
Date: Wed, 11 Nov 2026 12:56:46 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acl: reject rules with inverted range
To: Andrey Mokrushin <a.mokrushin@ideco.ru>, dev@dpdk.org
Cc: dmitry.kozliuk@gmail.com, stable@dpdk.org
References: <20261110062341.52126-1-a.mokrushin@ideco.ru>
 <20261111073041.38712-1-a.mokrushin@ideco.ru>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261111073041.38712-1-a.mokrushin@ideco.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi lads,

> rte_acl_build() doesn't check that for a RANGE field the low bound
> (value) doesn't exceed the high bound (mask_range). Field types are
> known only from the rte_acl_config passed to rte_acl_build(), so
> rte_acl_add_rules() doesn't validate ranges. Such a rule is accepted,
> and then:
> - for a 1-byte field the build crashes with a NULL pointer
>    dereference in acl_gen_node();
> - for a 2-byte field (e.g. port range 80..22) the build succeeds,
>    but the rule matches every value of the field instead of none.
>
> The check was done only for the legacy ipv4vlan rules
> (acl_ipv4vlan_check_rule(), now in app/test). Validate RANGE fields
> of all rules in acl_check_bld_param(), together with the rest of the
> build parameters, and fail rte_acl_build() with -EINVAL.
> Add a test case with the generic API.
>
> Fixes: dc276b5780c2 ("acl: new library")
> Cc: stable@dpdk.org
>
> Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
> ---
> v2:
> - move range validation from acl_build_rules() to acl_check_bld_param()
>    so rules are validated once per rte_acl_build() call (Dmitry Kozlyuk);

Sorry for late response.
Actually a stupid q: why we doing that check at build time?
Why tno check rules range in rte_acl_add_rules()->acl_check_rule()?
There seems no much point to accept invalid rules and defer error reporting
till actual build: if the rule is invalid it doesn't matter for how many 
categories
it is applied.
Konstantin

> - reword commit message: field types are known only at build time
>    (Konstantin Ananyev).
>
>   app/test/test_acl.c | 26 ++++++++++++++++++
>   lib/acl/acl_bld.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/app/test/test_acl.c b/app/test/test_acl.c
> index 5d207c8..47786bc 100644
> --- a/app/test/test_acl.c
> +++ b/app/test/test_acl.c
> @@ -1274,6 +1274,7 @@ test_invalid_rules(void)
>   	int ret;
>   
>   	struct rte_acl_ipv4vlan_rule rule;
> +	struct acl_ipv4vlan_rule rv;
>   
>   	acx = rte_acl_create(&acl_param);
>   	if (acx == NULL) {
> @@ -1338,6 +1339,31 @@ test_invalid_rules(void)
>   		goto err;
>   	}
>   
> +	/* test inverted high/low destination ports added through the
> +	 * generic API: rte_acl_add_rules() doesn't know the field types,
> +	 * so the rule has to be rejected by rte_acl_build().
> +	 */
> +	rule = acl_rule;
> +	rule.data.userdata = 1;
> +	rule.dst_port_low = 0xfff0;
> +	rule.dst_port_high = 0x0010;
> +
> +	acl_ipv4vlan_convert_rule(&rule, &rv);
> +	ret = rte_acl_add_rules(acx, (struct rte_acl_rule *)&rv, 1);
> +	if (ret != 0) {
> +		printf("Line %i: Adding rules to ACL context failed!\n",
> +			__LINE__);
> +		goto err;
> +	}
> +
> +	ret = rte_acl_ipv4vlan_build(acx, ipv4_7tuple_layout,
> +		RTE_ACL_MAX_CATEGORIES);
> +	if (ret != -EINVAL) {
> +		printf("Line %i: Building ACL context "
> +				"should have failed!\n", __LINE__);
> +		goto err;
> +	}
> +
>   	rte_acl_free(acx);
>   
>   	return 0;
> diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
> index 99d1dbc..534a0e1 100644
> --- a/lib/acl/acl_bld.c
> +++ b/lib/acl/acl_bld.c
> @@ -1548,6 +1548,71 @@ acl_bld(struct acl_build_context *bcx, struct rte_acl_ctx *ctx,
>   	return rc;
>   }
>   
> +/*
> + * Check that for all RANGE fields lower bound doesn't exceed upper bound.
> + */
> +static int
> +acl_check_rule_range(const struct rte_acl_config *cfg,
> +	const struct rte_acl_rule *rule)
> +{
> +	uint32_t n;
> +	uint64_t lo, hi;
> +	const struct rte_acl_field *fld;
> +
> +	for (n = 0; n != cfg->num_fields; n++) {
> +		if (cfg->defs[n].type != RTE_ACL_FIELD_TYPE_RANGE)
> +			continue;
> +
> +		fld = rule->field + cfg->defs[n].field_index;
> +		switch (cfg->defs[n].size) {
> +		case sizeof(uint8_t):
> +			lo = fld->value.u8;
> +			hi = fld->mask_range.u8;
> +			break;
> +		case sizeof(uint16_t):
> +			lo = fld->value.u16;
> +			hi = fld->mask_range.u16;
> +			break;
> +		case sizeof(uint32_t):
> +			lo = fld->value.u32;
> +			hi = fld->mask_range.u32;
> +			break;
> +		default:
> +			lo = fld->value.u64;
> +			hi = fld->mask_range.u64;
> +			break;
> +		}
> +
> +		if (lo > hi)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Check that rules added to the context are valid for the given config.
> + */
> +static int
> +acl_check_rules(const struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
> +{
> +	uint32_t i;
> +	const struct rte_acl_rule *rule;
> +
> +	for (i = 0; i != ctx->num_rules; i++) {
> +		rule = (const struct rte_acl_rule *)
> +			((uintptr_t)ctx->rules + ctx->rule_sz * i);
> +		if (acl_check_rule_range(cfg, rule) != 0) {
> +			ACL_LOG(ERR,
> +			"ACL context: %s, rule[%u] (userdata: %u): low bound exceeds high bound of a range field",
> +			ctx->name, i, rule->data.userdata);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Check that parameters for acl_build() are valid.
>    */
> @@ -1588,7 +1653,7 @@ acl_check_bld_param(struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
>   		}
>   	}
>   
> -	return 0;
> +	return acl_check_rules(ctx, cfg);
>   }
>   
>   /*

