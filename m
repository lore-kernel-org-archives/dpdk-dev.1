Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D43606A322
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CC+IRje4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B05714025A;
	Thu, 29 Oct 2026 21:53:07 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 48F2440151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 21:53:06 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so20336a91.0
 for <dev@dpdk.org>; Thu, 29 Oct 2026 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793307184;
 x=1793911984; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oHEJUi+NBdDca+Y6dLGlcm21ayHdVM2/dwd7oN020yA=;
 b=CC+IRje48vPLOEEbvJUa2u+sswcnFOQYhEqp+X70qJxvZ422Ru18CpUadmOqeeg8HI
 h2WWP/cP6m5qgZEuqhnj3ciB8vZMLCv6YYmSWhBDeyVaZw4+RVkFwYGgD3GCFYg3h7S/
 +Gd8TSEsTMGT4zkiwuBu8mqaKFNhxqi3ds+n7R9KEUDMUTnqiOuphFTN/iIWBWTZ/ntu
 Q14mEEhrG6uJOmZ76owc52uksC8LnvZhzvp8Vb7iJeJxespP3jiNoTxSIiFydXqiI6lb
 PxvLwUED/z8gWg2wag8xODk4VEirnINCbdDdL3yW/U6dyUz8wCfsf2Lga4rFFOTcuczE
 v0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793307184; x=1793911984;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oHEJUi+NBdDca+Y6dLGlcm21ayHdVM2/dwd7oN020yA=;
 b=BdD62wkQ3oVSYhQae1cD22fzAZLBA0+4Pomq6kMwcNjoBWmSiDr3WkaeeAyTONFBRM
 UBNcQlNiO0xue1q+gjVUI9GyJHIr+kI2wivFnW+Z9/Bj82mLHdk8SVbIAPW0wP3A1YjC
 Aos+Suw2QNPFVTnYS56PsBpip1lkGGItdw3rFkCq3OssGoV4xa8AkhCQWCy6LkIilJAc
 PEC+5WO0/QMgVU3yO+L2oZ0Wir7zpyQb/vIpYezbFhm9QBtdTQbYPZHxQgViE1wMxK4T
 GquOTHHV1aURnPc9cyv38nw0MYeXi9I3J57oz4woQwzBeMJlb3dUpCkBHAJJPMFNbwxb
 xVPA==
X-Gm-Message-State: AFq9FYKsUIZXLtGMiIGWHfKL66/JR/FcExXAnDM3x1wf6KXNpqvUMUyi
 XTpzM9BaNR/8O9d5NHoAXdewxd9S9KLJEKF5cPtF0vCNa2ieV11tJ5aKYlzgg86dQyg=
X-Gm-Gg: AYBFou2zQKFILUpDtfI5vx1WdtjZ4VYWDyadWn7rUvv0WCFf+mlErBjuVkQp3DGqMGl
 qpXTMBwbh2ct+rMtgVdEGlvB+hzK239Bnh+TR4+8HwWHmb40uqr1cQF1Vnm8DpErbpMVsr9Fgk9
 TdalHaFQKwenN7aV10+QRoRVz4oj9u1q6oDGkb0afrp6prvkmTuNRvzMDiLkzl/oFOIVQ+wTGpG
 mOdTRjBSStiFmoDpAOB6JWK7L8puUgTAjzccZ4cMzDGA3D08maeZgGir7BzsyRjJ8eMDu4/SJXo
 /Faq+Mq7SyK/n5UVI/Kof3Bk5K5Q4TlCZCeXFjfNVfwZBf2iY1/LUqJSAK1zGrPMZo5OlO+N5Fy
 Q+fT19nLKBEK+RSPtrm28gEvYnRaXtJ7uLFJ5eAmJZXzIkbWUytpBWd3wfBYJIt0C1dOXy1utk0
 NBG1jidceAv661cT2v1CCyYvVtqpmzuFENiHrqtBQUTCQnUWNTm7bwdFyrlq7fLV5esGEfq2Jn2
 SpEvmsGiSD82BjpsnRZn5vLIcAh1skf+UPAYqtsRHSYX/EE3FP4OH585wgTiQLWzoGI91Ca0Ckv
 Ro9qLxythgDfclF1mJD9gc96cbHB8HrcCGcau1cxnTP2Q3SzqfqUKG4HJh5ww74w6Dp8gzixTkt
 eQg0KKxRDIcKmuXVP
X-Received: by 2002:a17:90a:d2ce:b0:3ac:9176:e83c with SMTP id
 98e67ed59e1d1-3ae89720616mr151759a91.12.1793307184206; 
 Thu, 29 Oct 2026 13:53:04 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845df666sm988078a91.14.2026.10.29.13.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:53:04 -0700 (PDT)
Date: Thu, 29 Oct 2026 13:52:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 aman.deep.singh@intel.com
Subject: Re: [PATCH 0/4] move module EEPROM decoding to a transceiver library
Message-ID: <20261029135248.6d813f58@phoenix.local>
In-Reply-To: <20261029181511.1736967-1-roma55592@yandex.ru>
References: <20261014071245.2323258-1-roma55592@yandex.ru>
 <20261029181511.1736967-1-roma55592@yandex.ru>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 20:15:07 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> This is the follow-up of the RFC, for 27.03.
> 
> The SFF module EEPROM decoders do not depend on any device or driver,
> and they are also useful for ports which are not ethdev ports, such as
> kernel ports read with the ethtool ioctls. This series moves them from
> ethdev to a new transceiver library with the rte_transceiver_decode()
> API. ethdev depends on the library for its telemetry command.
> 
> Changes since the RFC, as discussed with Thomas:
> - rte_eth_module_eeprom_parse(), added as experimental in 26.11,
>   is removed instead of being kept as a wrapper.
> - testpmd calls rte_transceiver_decode() directly.
> - The tests no longer depend on ethdev.
> - The ethdev guide links to the library guide instead of
>   duplicating the example.
> 
> The library name is still "transceiver", as it reads better than
> "xcvr". It can be renamed if preferred.
> 
> Release notes will be added when the 27.03 release notes exist.
> 
> The dpdk-proc-info module EEPROM decoding (series 39575) will be
> sent as a v2 on top of this series.
> 
> Tested with gcc, and clang with ASan and UBSan: every patch builds
> without warnings, transceiver_autotest passes, the documentation
> builds without warnings, and the testpmd command decodes a module.
> 
> RFC: https://mails.dpdk.org/archives/dev/2026-October/348542.html

Manual AI review:

Subject: Re: [PATCH 0/4] transceiver: module EEPROM decoding library

Patch 1/4 transceiver: introduce module EEPROM decoding library

Warning: no release note for the new library. Add a New Features
entry to the 27.03 release notes, for example:

  * **Added transceiver library.**

    Added the experimental transceiver library to decode pluggable
    module EEPROM data according to the SFF-8079, SFF-8472, SFF-8436
    and SFF-8636 specifications. ``rte_transceiver_decode()`` can
    decode data read with ``rte_eth_dev_get_module_eeprom()`` or
    obtained from any other source with the same layout, such as the
    Linux ethtool ``ETHTOOL_GMODULEEEPROM`` ioctl.

Info: lib/transceiver/meson.build sources are not in alphabetical
order; 'sff_8079.c', 'sff_8472.c', 'sff_8636.c' sort before
'sff_common.c'.


Patch 4/4 ethdev: remove module EEPROM decoding wrapper

Warning: rte_eth_module_eeprom_parse() ships in 26.11 and is removed
here without a release note. Add a Removed Items entry to the 27.03
release notes:

  * ethdev: Removed the experimental function
    ``rte_eth_module_eeprom_parse()``
    and the ``rte_eth_module_eeprom_field_cb`` type,
    replaced by ``rte_transceiver_decode()``
    from the transceiver library.

