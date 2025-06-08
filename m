Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275DCC5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 22:23:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A23A4026B;
	Mon,  9 Jun 2025 00:23:08 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1AC644025F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 00:23:06 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7d21f21baf7so360228385a.0
 for <dev@dpdk.org>; Sun, 08 Jun 2025 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749421386;
 x=1750026186; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwUhKlpjJFH55iJqAjgsESf9ZRpzzwPaNmRFLvhPcRY=;
 b=ov8j3KmbXPr59MWU2rMHCKJelc/HaxBS3w220vgJI0o13t+Y2HpbKrJuNxze054qlc
 Wv7Dpay1G5zfdhx1ta9/Y89kudgLUUXV/2ZhQpPxQ3AcnPA4ZTH1hk4V2qDvAQMKV0NP
 6kHVAuKTSjtaFk/d8ypBCf9Dr0m3NyhEpBhJDlBI/7+hTjCaFSV32KZQEvCZzHgKon2e
 SYjelfyjxSi/CBQolPXWal9ReJq9en0qm8wQefbdDHRbosMzgTuxkpYzLAqWONhTh1Ja
 mrJu4KADpq/A+kZPEbF7IlvoTANXdUQ+R7w6VPnalnwBFMvDvO5ZRvnuxYqrUFIDTtfU
 9YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749421386; x=1750026186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwUhKlpjJFH55iJqAjgsESf9ZRpzzwPaNmRFLvhPcRY=;
 b=udpp7le6TVufag7a3873JXnrsXfcB9rPHguXZEgsCbFFLWZbu5RP59/qpp30Q50m30
 0kYQ7uI8jK/eZqN8kwMK7CYHKmFIzd5lpQJoxTxJaIgVMh1T0z2b19/60TFVoidv2L1j
 i3gNc4Jy2wtutJLVitj7Ly/pJwmMdHAGF8+u9Yi4E9FGA9a8tUI6bS/OrmegPsD7Xxxp
 +QdDBi6gNDmvAQacg2OchUoF82CsJQODif4L1xErhkX1mkpLe+B8kawmMXwSJ4uJKVHJ
 MwzC31AyBMER09Z+31DFy/yJNAyDnfWy8tyn/QxUIGHDw7vJWy8CxksYnbvJRQxrlIOq
 tVLw==
X-Gm-Message-State: AOJu0YygVDaXLKUMIU9TXH0z81mdmQR8adAzj5A54BvPVpaFoS4p732f
 jqaHX6ecgjPqa8Z1FPlaxbfqP8vHNgZGBmh69eHPFKpif4iz0y+gv2/n3Id/VcGOrPU=
X-Gm-Gg: ASbGnctGcwDcSUKJbPkgglCa1Ehyk1jDkAmOBSa0P41LTe42k0SWv98ZF17xPBBAqkI
 17nBCg5veqv2UoSwMVyJdvhyuI1qJL2erklvWa29TSMjgZqqsKtVXKLUzMf6lAHnDl7lHZqg4X4
 jA2USBpNy+j4hQNxZzfJ3ffQ9P1Y1qG8vEIGOBPcgLypHzt5cxhtVrSxqgDh/f1UyitH4Dh2BfH
 a4YtkfHTR90uKZSeBB/BnguMWlad/VRSyXnU9gs/86TqpneggVz+xO28FTsM0ZAMjmIK1M17cAX
 ooXYbSb1GTouL2nuBYF1CTo2LcR9nPIV4ZZQvRuX/wDujm4BuYHyud7DF1ND13y8szKrHAmMyYQ
 q3ZVy4iQXyXgz5UBX3uCn+2Xl8gtarnqwee2cIfA=
X-Google-Smtp-Source: AGHT+IHzfbZtIQLOt7OV1RPfpfRj7YfsRBWBot4Y8TbJXNFmFpMKG/EsComccXwJURqdm9mXZO6Kyg==
X-Received: by 2002:a05:620a:6695:b0:7cd:1f2e:dadd with SMTP id
 af79cd13be357-7d2298e0a52mr1542211585a.55.1749421386255; 
 Sun, 08 Jun 2025 15:23:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc19sm43333666d6.65.2025.06.08.15.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:23:06 -0700 (PDT)
Date: Sun, 8 Jun 2025 15:23:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250608152303.7fa38b15@hermes.local>
In-Reply-To: <20250606215208.389096-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
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

On Fri,  6 Jun 2025 15:52:08 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> From: Dylan Schneider <schneide@qti.qualcomm.com>
> 
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
> 
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
> 
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: stephen@networkplumber.org
  
$ ninja -C build doc                                                                  
ninja: Entering directory `build'
[5/6] Generating doc/guides/html_guides with a custom command

release_25_07.rst:141: WARNING: Explicit markup ends without a blank line; unexpected unindent. [docutils]

