Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A3606A331
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EQPWDiz7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1206E4026F;
	Mon, 16 Nov 2026 19:37:17 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D5A540150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 19:37:15 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cdb2e0062bbso1631387a12.1
 for <dev@dpdk.org>; Mon, 16 Nov 2026 10:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794854234;
 x=1795459034; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=envlu4D2mmkuehx/6u6a5o56iPJAuXkArLepCt3vUg0=;
 b=EQPWDiz7E26bJoAjYHefaoZPWZVDECF38n30WC4NejdlNL6lQKYeB8u+kBXArgYET6
 ZVRij5NccwfS/+hSOSMERYprDZDDaT1xD7ZGJcDgw4QJZk/m3brfRXAPSIYslwPcDzd4
 Cn7UyRvCbs2pirooikr6CJkklR+qVCEVZIm5xpPReFCACYuXtPNcUNkIr6dOLAaUGDe6
 mS60VPuKLBPEHNvVsXdrqXqlaMmG2PvKhdZQVsxI/mSkX6rAfFtBAuomP28HPSVhRgZU
 ICG1ZOvNof3Ohvt0hxfl1Ra/S+cIEXoydeMIaFfHV6fcv9ARWyxnjqUTVo4KR+Y3/QgP
 sG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854234; x=1795459034;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=envlu4D2mmkuehx/6u6a5o56iPJAuXkArLepCt3vUg0=;
 b=HCw5SdpnHZV4d7o8Bi/fObiTv63WBPbYhkSrd7164BniR1wixw+SHYeLDTONumFzhc
 rd6zM2xC8Ffx1frSDUu9CsMKhxKE9H81Vu5j+sSnbTcMULCtG9mfly1uBjjSg80Hf3d0
 vh2a7cBqgerjk8TCBFMLuUEd10yK+FIxXQKFXdIiEkNPRrSrMKQ+EqNpE7FeFXiufE/a
 3eavXDVA0WqsvZVREnP2iAnnXb+ubVcWqOJDXquklcz/1fJuJy9JcH92KzJFgDklz3ee
 a82nlS3fcBMBLXJuZYD/V/qf52uPMuQuIwMzSgCK6hE1lsm5u4GNPbi2to+10U4z8K5g
 vofQ==
X-Gm-Message-State: APuU4Z/MwQwXmSLFZCXHIcc3Z+AAIXhMQG2/uFJRaLKYc3Gr8HtpfW6z
 h+Cx4cLu6vnMg6ep7Tfy2LtYCYvjb6dsp+DgJcMzPLFCMfo0SjnSuS5oZ9uGOI25gxlLHwlsztH
 zRoeysm4=
X-Gm-Gg: AZFdTZcNERmfEx86ZfwUt7mrvWf5vkFxCCYIOcJz0lK+PrFah8/LRceoyDOmBao0ZhL
 PKrNfMISeQQZ/yfYyYUQQLeKu2kP2qhXd6nYUkr2H5/qG5V1NyXveHrBuqB/a/nAWHReYJvm2+L
 N5H3vt+qeVnFu/UY5arD0ubjO3yOx2ili/+qrci66EsZM0r1VEukhf2yvRCAPIfpWzJAZER2yvz
 XCDc3W0XpFoYNhpBSRlQegn30gNY2o82lp3YIDBeXfJX78d4vLF7Ij7FXD/Uy+avqF53dbwPMGl
 OqGphbgiD5I6xVRgPKKsDXsq6audpqQIpr9qLIyy7EQ1MmMrDYVQNlTxmBFNppq32tPTPYLobNR
 Dr+ty48f0/E6laMdxipP+Jj/CFLP1GQP4uxCjuZJP/bB5mJrAk4qlx3g03420hpsCZG9W569gsO
 1Y0uJN9PRK+IpuPEDoSQWRvJHnU85OfUKdl3q2ZyGZNYy7/O3bV0H43AGzcbN5xfj+j9ZyKpjnX
 5VBkHpov8hklacNV60d60oUve9rkSpROMUaZoAxsUmEa3diJfzdXQF6ykmprZYP/a0XhQDABl7X
 rfweyzrSJWeM2X1iplIIDPN7lrKtvNL0ANzas30eVvZkmgbfRHEjxX9/cyilW6s5fMwgq6QfF8w
 =
X-Received: by 2002:a17:90a:e54d:b0:3b3:a74d:f848 with SMTP id
 98e67ed59e1d1-3b3a74df977mr564795a91.15.1794854233710; 
 Mon, 16 Nov 2026 10:37:13 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abd068e2sm420884a91.6.2026.11.16.10.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:37:13 -0800 (PST)
Date: Mon, 16 Nov 2026 10:37:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Reshma Pattan <reshma.pattan@intel.com>, Aman Singh
 <aman.deep.singh@intel.com>, Naga Harish K S V
 <s.v.naga.harish.k@intel.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Anatoly Burakov <anatoly.burakov@intel.com>, Cristian
 Dumitrescu <cristian.dumitrescu@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v5] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Message-ID: <20261116103711.45e7d6e5@phoenix.local>
In-Reply-To: <20261115213640.1037602-1-stephen@networkplumber.org>
References: <20260409013658.965613-1-stephen@networkplumber.org>
 <20261115213640.1037602-1-stephen@networkplumber.org>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 13:36:21 -0800
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
> Update all in-tree callers to pass the size of the buffer
> and add checks for return value.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

I think this should go into 26.11 just because it is easier to do
API change in LTS version rather than having to do function versioning.
If not will resend with function versioning for 27.03
