Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC2ACC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:12:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCD92406B8;
	Tue, 13 Oct 2026 17:12:07 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 9863A406B8
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:12:06 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3a4b3ac8fb7so1381422a91.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791904326;
 x=1792509126; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HZmTtxZoSJgGKuHo7SX3lLrXQhtP9gGXi87JZeqlPDU=;
 b=jQS0xNuUpjOCfFOHM/rIq7Tsb/fEcV5LUEfx0brAAhYFStt65JXGemDcF4BvdZrDk0
 J8NKv6lcRQuPLKM/7a9ov3e4uFn/XxCnYvTGls6/VrvyCxo5Mrqjhd6xJO3bAq8Pbq6t
 +D+4vNTBpXElDggzYjZ0+VBxJhQpjhsdzsj1hAOLNKOnUr8NW67FBf3wJS4P2/OItmAW
 /gfxu3ZHiR8IwAKP2FfU1SVlEgsAEnRNC6qSlkoa+or1POFxUtjpz6rnOqs3VcRg9h1A
 jEU51bm4f1q1iwkk//v/IxV85WB1IJ4ZqAK6sMraMHembcWW0/1CF4+B2CddV8ltO9Dp
 WqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904326; x=1792509126;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HZmTtxZoSJgGKuHo7SX3lLrXQhtP9gGXi87JZeqlPDU=;
 b=JOfCLcla3wi+/mzFyNpARghDeOZUAMonE6He02OCiu4gj4vYtuRL/4QFLdvXd4Dbbl
 IDKjLz6QuVKcEW5/6O3YuXVBQjt5GWVsXs3l+HZqugR9GcMH9V96uQfUvks0baUWtvhY
 H7LiOxV2SUJmeqOvUbA8HSAlhqQVeDZNmiy7h2Cr5n2YpR6dSLfZxB3sS9cMsDiRkeST
 dkPSwl+HIHnpTZCagHgB2uM93ViGfmiwDNQJCfmB9untn1tC3ZpOlmCckmoMRlfhRxG5
 3s2K0/r2ND3BErTPzuPxBfDosnSJbwCbEst1TQdoC6BKw1YjRLfxNvjPZsTLNSYu8NIk
 XM1Q==
X-Gm-Message-State: AFq9FYItzw7x9oc0VkGvzgRwj8rRyHSFLqsV6Di+IVVT5EO4neJlNfMr
 A447TkuHTnrOHD0CKx7qjCorO/qM9aTA0wFrxJlptA5DfRlKCisb8R5hDc12p8aeHf4=
X-Gm-Gg: AYBFou1Ahxdx8yxoCF/hS1nrF3Px6mW6Tw9tNhhuCmkMigBg7Nppwgtog8XhOt0WDSZ
 U39Ew8qq3ehNe+ubTiionrrwcTPA0ff2KBs5Fi85nerZ/8ljX3ycwyCZrcQ+JJSVl3RINrvt/v0
 BgAJg2EkwpGXD6NPvoSMIBGojPVnm3Wp1GFdnu2Td6eYZPpcQb1nVGsJoQJKEzlsqt0tG2rx9Ki
 9WsD8VLNeRYESZmvuenWV9Vyu9B5jHtfQjHWejrvPqHfiEvPX5eMslm0glq5P/YL9L6p0v6f+Ww
 /3J7V4dYPqJX3BnX7t3sQdwfRLuQ8fn/vjhBUmsMfwrG81RNLkwfXqEDJlnfS2RYuCURSPG0+09
 avvx0UI8Y3Xl9ORWd8PmHFSN1ADHKmQDM5qIoECBbfBCzy0I4cMplmO2MlQjPDGhVIG5eeM38Dv
 fFw+ycumV0kEIgXMw10cfNXLneo0fmMoJMiGci6j3Kn6QvB+JUNOZz5TYflIhFsxaGRweS4/DD8
 ez8BTtmLDXpHxf2YWMWME2ll/na08MstWmdVkA3xrpNSWfBlyE=
X-Received: by 2002:a17:90b:2786:b0:3ab:b39f:41cd with SMTP id
 98e67ed59e1d1-3abb39f44eamr6515795a91.60.1791904325604; 
 Tue, 13 Oct 2026 08:12:05 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f05083fsm35116a91.1.2026.10.13.08.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:12:04 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:56:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: Re: [PATCH v9-S2 05/13] net/dpaa2: support meter and policing
Message-ID: <20261013075655.254a7f45@phoenix.local>
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

On Mon, 12 Oct 2026 12:34:36 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> +
> +	/* Check for duplicate ID and insert under lock to prevent TOCTOU. */
> +	rte_spinlock_lock(&priv->meter_lock);
> +	curr = LIST_FIRST(&priv->profiles);
> +	while (curr != NULL) {
> +		if (curr->profile_id == profile_id) {
> +			rte_spinlock_unlock(&priv->meter_lock);
> +			rte_mtr_error_set(error, EEXIST,
> +				RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
> +				NULL, "Meter profile ID already exists!");
> +			ret = -EEXIST;
> +			goto err;
> +		}
> +		curr = LIST_NEXT(curr, next);
> +	}

You are just open coding LIST_FOREACH() and other places.
Better to use the macro.
