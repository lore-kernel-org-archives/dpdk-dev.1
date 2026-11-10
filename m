Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226E660A2626
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=CU6kMhhc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B2BB40283;
	Tue, 10 Nov 2026 10:59:44 +0100 (CET)
Received: from forward502e.mail.yandex.net (forward502e.mail.yandex.net
 [93.77.172.87])
 by mails.dpdk.org (Postfix) with ESMTPS id B20AD4027C;
 Tue, 10 Nov 2026 10:59:42 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward502e.mail.yandex.net (postfix) with ESMTPS id 449A110009D;
 Tue, 10 Nov 2026 12:59:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 dxOWTtAij8c0-em9OHMuj; Tue, 10 Nov 2026 12:59:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1794304780; bh=bnwa45hsPtl6YU6RDE54c04PVL4HBbC/xvuzhYuWBMI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CU6kMhhcg7cDjqDDCkE3XFaYqSRa1fvQB8/qehXgfNtvJo3JNYCwlO1cIvzJ4+VaA
 I1E00pShlTNxVN8qLN8CmmGVaWRHLlRNJGDp9vYhHUNJchRm7mcoiNQIdfPirzFYIp
 fVop7KMN1mF9UAL6Mf8kxuRqLvhPf/b22CxU5Dcc=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@yandex.ru
Message-ID: <e4db7c62-3532-4e9b-9bd8-cb1e4e074c7d@yandex.ru>
Date: Tue, 10 Nov 2026 09:59:39 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acl: reject rules with inverted range
To: =?UTF-8?B?0JzQvtC60YDRg9GI0LjQvSDQkNC90LTRgNC10Lk=?=
 <a.mokrushin@ideco.ru>, dev@dpdk.org
Cc: stable@dpdk.org
References: <20261110062341.52126-1-a.mokrushin@ideco.ru>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261110062341.52126-1-a.mokrushin@ideco.ru>
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


> From: Andrey Mokrushin <a.mokrushin@ideco.ru>
>
> rte_acl_build() doesn't check that for a RANGE field the low bound
> (value) doesn't exceed the high bound (mask_range),

>   and
> rte_acl_add_rules() can't check it, as it doesn't know the field
> types.
Hm.,, I don't understand the statement above:
"rte_acl_add_rules() can't check it, as it doesn't know the field types."
That's exactly how you fixed it below: by checking type and
applying extra checks for RANGE type.
Overall - good catch and good fix, thank you for doing that.

With the commit message fixed:
Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

> Such a rule is accepted, and then:
> - for a 1-byte field the build crashes with a NULL pointer
>    dereference in acl_gen_node();
> - for a 2-byte field (e.g. port range 80..22) the build succeeds,
>    but the rule matches every value of the field instead of none.
>
> The check was done only for the legacy ipv4vlan rules
> (acl_ipv4vlan_check_rule(), now in app/test). Validate RANGE fields
> in acl_build_rules(), where the configuration is known, and fail
> the build with -EINVAL. Add a test case with the generic API.
>
> Fixes: dc276b5780c2 ("acl: new library")
> Cc: stable@dpdk.org
>
> Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
> ---
>   app/test/test_acl.c | 26 ++++++++++++++++++++++++
>   lib/acl/acl_bld.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 74 insertions(+)
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
> index 99d1dbc..aa25c78 100644
> --- a/lib/acl/acl_bld.c
> +++ b/lib/acl/acl_bld.c
> @@ -1443,6 +1443,52 @@ acl_build_log(const struct acl_build_context *ctx)
>   	}
>   }
>   
> +/*
> + * Check that for all RANGE fields lower bound doesn't exceed upper bound.
> + */
> +static int
> +acl_check_rule_ranges(const struct rte_acl_config *cfg,
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
> +		if (lo > hi) {
> +			ACL_LOG(ERR,
> +				"Error in rule[%u]: invalid range for %u-th field",
> +				rule->data.userdata, n);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   acl_build_rules(struct acl_build_context *bcx)
>   {
> @@ -1467,6 +1513,8 @@ acl_build_rules(struct acl_build_context *bcx)
>   		rule = (const struct rte_acl_rule *)
>   			((uintptr_t)bcx->acx->rules + bcx->acx->rule_sz * i);
>   		if ((rule->data.category_mask & bcx->category_mask) != 0) {
> +			if (acl_check_rule_ranges(&bcx->cfg, rule) != 0)
> +				return -EINVAL;
>   			br[num].next = head;
>   			br[num].config = &bcx->cfg;
>   			br[num].f = rule;

