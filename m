Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2850CCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 02:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 048C1402AB;
	Wed,  3 Jun 2026 04:20:36 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id EAF89402A9
 for <dev@dpdk.org>; Wed,  3 Jun 2026 04:20:34 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304d8362a58so142248eec.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780453234;
 x=1781058034; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VfyGeqe2X5GashOpkZwSdQyC0SO/ubXjAhgkG4FdxY=;
 b=yvgdZ/nm1QgVEscBMG/zC4NNeohpd1mXAdZeo5/f7n1SzIXg3FIrdYilVYvO0bv3xu
 YDjniCDu1IcBPoPHfJXnoEbFEaT/0tjt3WBD4itzvpw38jf+Ip9BCbEOwJuCoL7denjO
 JwnZHMLuz8eciQe8ZL+G6Jv2AQ1h3bn/PtbSP9Lb1sqSO5ZDZWpUKnsGZeYp9LrbfMYN
 pERMvQOHfUv/kvBfhiIK4ExDIdocqHO+bmXVeAXIyg33/LFNumyLHITpn+COoLZoyl22
 PQ+izMGjCEMw1ymCsGXErw3bRMXjynD0aV6DwrIMz4QXdO7aUthmu/RVRD2YQI5Qg01a
 aGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780453234; x=1781058034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/VfyGeqe2X5GashOpkZwSdQyC0SO/ubXjAhgkG4FdxY=;
 b=VwoejphIuAMNuL75zscMo0iqILnKj9nd4D1gsxtA8CmF9zQqDcKs7Lefyc89UIZVr3
 IQPUT1T1m1ARgKFRf3zmJCs3/+/xAz7Ik+NqIOTery16ms9migDyKukcIy0Od9mnd4lY
 dKe3pxfB/MvPnP5V0mS6bHXBPwBlL6wTq7v46vGFwRLaoqw7yOejUn82Zd4499gZCLlV
 915ticF8zvb/wi40SQwyvidArrPmPmfzQvgOb1301I15r8vrOBK35athUHTatIxp4iv6
 nJ4Wm9p5dQhey1sw5d2TjlSAImtciMsaJmiIsi6OEKm7wkD+OFzT7nWQ33iD5ohwiZzb
 fMwQ==
X-Gm-Message-State: AOJu0Yxqbxq+X1wH3y42AW0HEZY2jyO2OoENfRN5ezQH4Jb8lcGhORq1
 K7MAy+SgMiW/iQHOr89DARahVhuhNfbNPx94FPpt+ACZZoitZLjZDNIjEtVX/ulEC5bFKr06QYH
 kqEsk
X-Gm-Gg: Acq92OH359SusYPsf+v+v/qTuNW+Z6bdZBpcX9DNRmurfohRIe1iJyLnOSbH8Z8nlLm
 6DAfqMNgZ05x4yoJcQ8aosiwPpS9e8AAE8ANPrBPpIef9+1CrACyU90SHpCl15h4HRSj6oYby2H
 wA6KqeaCuUqiD98ElWni08SNx4HP6r6w+NDNLPeCNcWxKgRm6sOB50KJw4xMppWTEkgpyOFiTcm
 2nRUIJkqB95kEcyPRyrCy/5YHzQKDF1siQ3Ru1vmXMbvvwYvLBDnfHgfoTlDp0cvg2gDe9/DkhI
 +0m8Nse/de+uubXIPpzpv1Zku3hlMRNXx/cPsCSmbUkBqJM9028vLPN1GDf1US4Pibt5nvwiR5E
 pzRdOyj5r024nwm1TVlPDDKKQkK355CTuXBnA/VDGgbJO3P5UflM3UD9NX7rzVfoUh2yK3j0mU4
 dTCdI4pQkZQs6+WWXDyEa8++WeBEYL2iX6iYNPocIA3XevJzVp9obV2XrI8p8bvQL6aEihQ6TiC
 Ow=
X-Received: by 2002:a05:693c:2c13:b0:304:bd90:b88f with SMTP id
 5a478bee46e88-3074fb81915mr660187eec.9.1780453233586; 
 Tue, 02 Jun 2026 19:20:33 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df75ff6sm1142813eec.26.2026.06.02.19.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 19:20:33 -0700 (PDT)
Date: Tue, 2 Jun 2026 19:20:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Reshma Pattan
 <reshma.pattan@intel.com>, Aman Singh <aman.deep.singh@intel.com>, Naga
 Harish K S V <s.v.naga.harish.k@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Anatoly Burakov <anatoly.burakov@intel.com>, Cristian
 Dumitrescu <cristian.dumitrescu@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH v2] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Message-ID: <20260602192030.2e2ae215@phoenix.local>
In-Reply-To: <20260529000748.275863-1-stephen@networkplumber.org>
References: <20260409013658.965613-1-stephen@networkplumber.org>
 <20260529000748.275863-1-stephen@networkplumber.org>
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

On Thu, 28 May 2026 17:07:48 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> rte_eth_dev_get_name_by_port() uses strcpy() into a caller-provided
> buffer with no bounds checking. A mistaken caller that supplies a
> buffer smaller than RTE_ETH_NAME_MAX_LEN can overflow the buffer.
> 
> Add a size parameter and replace strcpy() with strlcpy(), returning
> -ERANGE if the name is truncated. The copy is now performed under
> the ethdev shared data lock so that the name cannot be mutated by
> another process between reading and copying.
> 
> The previous ABI is preserved via symbol versioning (DPDK_26) with a
> thin wrapper that delegates to the new implementation with
> RTE_ETH_NAME_MAX_LEN. The versioned symbol will be removed in 26.11.
> 
> Update all in-tree callers to pass sizeof(name) as the new parameter.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> ---

Since function versioning breaks LTO (see Bugzilla).
Holding off on this until 26.11 where versioning not needed.
