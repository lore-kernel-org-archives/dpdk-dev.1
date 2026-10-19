Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B8C606A324
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GidWdmWt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B4A40298;
	Mon, 19 Oct 2026 18:19:46 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2E09840298
 for <dev@dpdk.org>; Mon, 19 Oct 2026 18:19:45 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2e940d5d2beso9289495ad.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792426784;
 x=1793031584; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vSO5ZWaXvSN3CLYi1MGgkR0SuACznYFdVYXGNK+GLW0=;
 b=GidWdmWt3NKmd9XgZu+goIhpmdSOt8Te48ZL0ax3a30c+U7AKjYCEVPV4yfMDlrO6i
 Pb/ldYrYBPfvGswmJb2JyvUm6WpfDQnCu4Oyf2tIovPFiZROP1RHos96vvAhOeclXuCE
 4qXoeEqvtXhMJy5CMIBqjdnkUHV4Ub1h+1zNVHwazvPtmm8O602oM/AkiELhMc/I2dPw
 6i5cEDZ1HGJ4sWJimY3QNYP2t2CrxlXjRCO/SjtRK6Q6MLsNHU8n1AeL3YfA5It+Gq5o
 proVrUPGb47EB/HbyD3cSCx7EPw0k1huOP+/rqGQQrT3AefcShQCEquo0QYD8nvzGvIP
 aDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426784; x=1793031584;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vSO5ZWaXvSN3CLYi1MGgkR0SuACznYFdVYXGNK+GLW0=;
 b=1ApMqO3hTV//OdOTLHoqY1JMOLU67R31OA82HbBUbj4F81xV5YZfZsJ07K6B2NKFUl
 pIumtYIC1mpx4ILNmXyTaoEDOQrAcSpVtk6sGKOlwaUt57O50y7HSlRiXtdLgXZ5qZ2W
 69Ny6KQ3cCT4/RvLbs6VVKy9tvZmmgOhNX5iN207k0D3piFEUWifqxszA0eEYHeVxG6y
 deuuJovUwLWpkjEdaAHtwVJH3pEBMThrm0L/2EUl3GE1Mv+0WrkaiFHjRw+r4UzYKekm
 ku1ghVKVXeirUmMRSgE09DbaWZyQ5S0IZB71EOHDeenFQjzYSzDfyLxvLytjzdgdarD/
 IQMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTqjxbcmJ/iF/Cd145U9qdNAoNTufncdvrwgnDahuF3t+utmuPauJ8aKIFjRdBVKWqLC0=@dpdk.org
X-Gm-Message-State: AFq9FYLO3LmQ/viT5RilOd9R3mpIMCsTcJzhM7dPa4D4aQZHQKTwsb9/
 0+W6e+oy/VNgsxg2TznPOK/1u8/b531BCFFzImQrAP1QgL3+1e/vqTgOSVt8CrYwBajJKIEqJOK
 nlDj4
X-Gm-Gg: AYBFou1VwvQBrYGVZsgTrgo3xfXFixe3glAHrfVbCHqnhE4hxjOPuoJ+aWzCPb7quoo
 TFiCXER4XHtHs8Bbbe0pl+WCS8kb4Gavyh4RsZnnDXjMOLzWIFXGUinB3Nul/fBh93DtchOMqFD
 y3AXKZdfTrK7+7Lqf2YFrSxt66QCoWigDWYN+oHgZMfY2mk/ZYg6gSoOgS0gCLtAXxqlibFnit4
 8fw6RpaPt7x4hOcNv4CE6sOMdvX8dYrvL0FtLvu6TDCt2YNu5MLN2KbuI50yIUBIW9ZH2Dbzrgh
 tToG819+BQ/rj4U3LKVQDgHW/0tMwm23JYMDLM+LL/E2WtlA5qHj5x8Wsyz86vZOOeQeowK4brY
 C98uAGb4DEjf8bb8IS3GxP6+ex8u0+nE9fNFnzUW+gwdy/3UlXDZtO4Cc3w/ZiraeHVZSX7SwSL
 xAFDF5fe3lCth/l+n0P6lSL1e3VYuaF0QsR6LTeJGcSbx+rqF5me9dNCjtdU1VmhAKk5AIfHKqr
 U4GXT2P3yptOgYQhPoI8CG83h2lo76OJIr4UQUU
X-Received: by 2002:a17:90b:4f4c:b0:3ac:403d:6239 with SMTP id
 98e67ed59e1d1-3acef3c38f1mr6532649a91.43.1792426784095; 
 Mon, 19 Oct 2026 09:19:44 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad5d4004cbsm141808a91.3.2026.10.19.09.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:19:43 -0700 (PDT)
Date: Mon, 19 Oct 2026 09:19:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <dpdklab@iol.unh.edu>, <test-report@dpdk.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: |WARNING| argparse: support range step for corelist parsing
Message-ID: <20261019091940.5f31d146@phoenix.local>
In-Reply-To: <73b5e9cd-6789-422a-9679-88693c60352b@huawei.com>
References: <<20261016093001.9067-1-fengchengwen@huawei.com>
 <20261016101228.123E46051830@postal.iol.unh.edu>
 <73b5e9cd-6789-422a-9679-88693c60352b@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 16:36:12 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> > When `step` is large and `min + step` exceeds `INT32_MAX`, the loop counter wraps around to a negative value, creating an infinite loop. The variables `min` and `max` are `int` (32-bit signed), and `step` is `int32_t`. If a malicious or mistaken user provides input like `"0-100:2147483647"`, the addition `min += step` will overflow after the first iteration.  
> 
> False positive, the:
> 		errno = 0;
> 		idx = strtol(value, &end, 10);
> 		last = end;
> 		if (errno || idx > UINT16_MAX) {
> 			ARGPARSE_LOG(ERR, "argument %s contains a numerical value out of range!",
> 				arg->name_long);
> 			return -EINVAL;
> 		}
> already treat such input as an error.

Since non-negative steps don't make sense, I would use strtoul() instead
and bound it by MAX_LCORE

