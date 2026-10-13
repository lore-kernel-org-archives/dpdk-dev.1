Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17C2CC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3C8140693;
	Tue, 13 Oct 2026 17:11:40 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 6FC7740272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:11:39 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so157972b3a.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791904298;
 x=1792509098; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Q/dJ5kpOMvj8GbVEAXlxryyMKBtJ1wRh7FrbfGa3Tg=;
 b=IaOtqM3vKr7DDESQum/5jYYvXhKAVkVASV187EURKYvnm2rEAw2YH4lSJMUInPAOGc
 YIK4nvmXQBssi0u4OfCFLzIfIkvyv/nk4AFAF+VydMXQZftM+WqTolQi/M5OTJVYAVQs
 QcfqLyd8/qnl+F3EasJeUvEHhKOV+DJQZrsbSNmNl/EoRtuLbnuZZ9DRVoHCqLetll4H
 GxRjUJ+6ZtPN23nZNUXI3+7b1in9T+BkxBeyuOlyVDiUsQae7va28WoVEtTIxLaFYaRh
 bKHxKw7XB2XegiS52hXEbgDTwy+xUefCtfDNLV459CHmbq2s3WeORRS4zZBxsqN2T7M1
 sS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904298; x=1792509098;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Q/dJ5kpOMvj8GbVEAXlxryyMKBtJ1wRh7FrbfGa3Tg=;
 b=goC6FBCPo/GT1zSMwpDH2THUr/zKBTG/qivX8uTj+HOSjhAuTxVlcqjoI3Zu8FqPIK
 zbSMwso2gpgSbOKNSq8Dy92mnaLjubtzgqVcij8gDoOSZO9I7i9pGboa+p0P7x+x4QV2
 nfhUK+GwtfzlCtmSupsalc7HfudIQCzILhWSVTUoSUNWX2TrU30n6PFVFCBSrqCypkOr
 KzeKePlFklxZ+cHVmwY6JeskRZsH95JZctnamXDMs+lWEwn50L9wRLA8ueyvZnrmXVGw
 XuwidaKt7ANBlkwTbCxQntAuE9Y0GNiSUE8hJox7U5UolFn8js7vigRU1UwehMpBiKRJ
 7xwQ==
X-Gm-Message-State: AFq9FYL+XP3bOz5BAsVSgOrI/V5EWJS51wjkh89qMLInBR5M2+OWoqdt
 +hmt6T7xKejvqxPFTINzFg+p0PqXZV14cX7dvo8ZquHX25YaKivf/igs1UgkJZ+yQkI=
X-Gm-Gg: AYBFou23k+mkWPKuXqI570bkki9SfUqjV2dOppJ5VzWKPy5K4ji4XkS2busGxuPZqur
 v9gq6mvaHg5/OvxEfm39U7iaQrE2lgCa/yOz9EDamotV7Gd8VcWvcP9WhUFb8/m68KotkLozTh5
 YKUcz7ztoo1k+povwPs6JBE/+RTfFuFZOuLybEVuDsQvSgZ1mZxEAHPx502iEo4EEbxmjkEypfu
 09b1dSq/ZICAgkjvZ3WnjIDdeV0oDfEevlPD33aKs1mU39Hlhy27aVm1kUd0Cr0YMqTwnWK51lQ
 v0RoT9XhbUtYp9xY0lI3nwZbaXbG2yClBAF1WrLFXM5cbwcz92hi4IbDK8+z2a4GtVguAGkz5Km
 PEMW+0rlvhivt0pSDw1PEQNiRih5j+FvPpSPnhc71Yy412CqFUynhpbhLdRQ4z4efYsDCY+bqSM
 bwkLaQwIxz15nBzC/mm0O0cFXDgdg7mtxD61MLS6pagptqsA5AFWNxJ7G++yqjbG7ID5ev8z6aC
 gotI+iGhNUXZxzJWdaYCq3MIr7xmhfQeEnmO+2G
X-Received: by 2002:a05:6a00:2181:b0:89c:e375:1de9 with SMTP id
 d2e1a72fcca58-89ce3751f88mr1560250b3a.4.1791904298336; 
 Tue, 13 Oct 2026 08:11:38 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c310737esm5425147b3a.10.2026.10.13.08.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:11:38 -0700 (PDT)
Date: Tue, 13 Oct 2026 08:11:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: Re: [PATCH v9-S2 05/13] net/dpaa2: support meter and policing
Message-ID: <20261013081130.71d8a852@phoenix.local>
In-Reply-To: <20261012070444.2149617-6-prashant.gupta_3@nxp.com>
References: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-6-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

There is a race here.

> static int
> +dpaa2_mtr_meter_create(struct rte_eth_dev *dev,
> +	uint32_t mtr_id, struct rte_mtr_params *params,
> +	int shared, struct rte_mtr_error *error)
> +{
> +	struct dpaa2_dev_priv *priv = dev->data->dev_private;
> +	struct dpaa2_dev_meter_profile *profile;
> +	struct dpaa2_dev_meter_policy *policy;
> +	struct dpaa2_dev_meter *meter, *curr;
> +	uint32_t profile_id, policy_id;
> +	enum rte_mtr_error_type err_type = RTE_MTR_ERROR_TYPE_NONE;
> +	bool found = false;
> +	int ret = 0;
> +

...

> +	rte_spinlock_lock(&priv->meter_lock);
> +	profile = LIST_FIRST(&priv->profiles);
> +	while (profile != NULL) {
> +		if (profile->profile_id == profile_id) {
> +			found = true;
> +			break;
> +		}
> +		profile = LIST_NEXT(profile, next);
> +	}
> +	if (!found) {
> +		snprintf(s_err_msg, sizeof(s_err_msg),
> +			"Meter profile ID(%d) not exist!", profile_id);
> +		ret = ENOENT;
> +		err_type = RTE_MTR_ERROR_TYPE_METER_PROFILE_ID;
> +		goto quit;
> +	}
> +
> +	found = false;
> +	policy = LIST_FIRST(&priv->policies);
> +	while (policy != NULL) {
> +		if (policy->policy_id == policy_id) {
> +			found = true;
> +			break;
> +		}
> +		policy = LIST_NEXT(policy, next);
> +	}
> +	if (!found) {
> +		snprintf(s_err_msg, sizeof(s_err_msg),
> +			"Meter policy ID(%d) not exist!", policy_id);
> +		ret = ENOENT;
> +		err_type = RTE_MTR_ERROR_TYPE_METER_POLICY_ID;
> +		goto quit;
> +	}
> +	meter = LIST_FIRST(&priv->meters);
> +	while (meter != NULL) {
> +		if (meter->meter_id == mtr_id) {
> +			snprintf(s_err_msg, sizeof(s_err_msg),
> +				"Meter ID(%d) exist!", mtr_id);
> +			ret = EEXIST;
> +			err_type = RTE_MTR_ERROR_TYPE_MTR_ID;
> +			goto quit;
> +		}
> +		meter = LIST_NEXT(meter, next);
> +	}
> +	meter = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_meter), 0);
> +	if (meter == NULL) {
> +		snprintf(s_err_msg, sizeof(s_err_msg),
> +			"Meter memory alloc failed!");
> +		ret = ENOMEM;
> +		err_type = RTE_MTR_ERROR_TYPE_UNSPECIFIED;
> +		goto quit;
> +	}
> +	meter->meter_id = mtr_id;
> +	meter->profile_id = profile_id;
> +	meter->policy_id = policy_id;
> +
> +	rte_spinlock_unlock(&priv->meter_lock);

At this point meter is created but not put into any list.

> +
> +	/* Program the hardware policing configuration for this TC. */
> +	ret = dpaa2_mtr_hw_program(dev, mtr_id, profile, policy);
> +	if (ret) {
> +		rte_free(meter);
> +		snprintf(s_err_msg, sizeof(s_err_msg),
> +			"TC[%u] HW policing set failed (%d)!", mtr_id, ret);
> +		return rte_mtr_error_set(error, -ret,
> +			RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL, s_err_msg);
> +	}
> +
> +	rte_spinlock_lock(&priv->meter_lock);

While HW was being programmed, in theory the policy and mtr_id could have
gone away. Either refcount the mtr_id or do a quick rescan to make sure
it hasn't disappeared.

> +	curr = LIST_FIRST(&priv->meters);
> +	if (curr == NULL) {
> +		LIST_INSERT_HEAD(&priv->meters, meter, next);
> +	} else {
> +		while (LIST_NEXT(curr, next) != NULL)
> +			curr = LIST_NEXT(curr, next);
> +		LIST_INSERT_AFTER(curr, meter, next);
> +	}
> +
> +quit:
> +	rte_spinlock_unlock(&priv->meter_lock);
> +	if (ret != 0) {
> +		if (meter != NULL && ret == ENOMEM)
> +			rte_free(meter);
> +		return rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
> +	}
> +
> +	return 0;
> +}

The code would also be easier to read with helper functions that
looked up in list rather lots of open coded list walks.
