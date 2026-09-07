Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB0C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:07:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E54FB40A6C;
	Mon,  7 Sep 2026 19:07:15 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id E2C64402DE
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:07:14 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ceab75934dso35150165ad.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800834;
 x=1789405634; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eutIbrvLnG5faTCUfCDkUQRji4RJOxBQqahDIheqeno=;
 b=YikWG9oH9S7GX7e+qfkg5RPsoJQzpQ1HnPK/DmlZwXytsU67K7k+Tap4woTlg55WXP
 mhssDAkVggU7oDBu/xW8/yjjyO9ANJaVMO2VewJXdHOEJ7Oo3lsHjl7xxNNlnQFMWEkf
 +dD4Rr+yAvWiZXCu3iZZnLXE+oKuSkZLk+Tpn+65IGEud37ycBRu4chnJkWEchjfiS3I
 G34ChFpkyr/PFNc1usqYHr0CGqXNQJSwPv4HBdU5PI0/+2iNTBvCM8D6zLigYbIR0XOI
 Dw3KzV4u5lR1YP8em8CUZA++NEq0diWY92xvgYmbSJQp42Is8NSLPuLJy+ITNa3Qzvt+
 qfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800834; x=1789405634;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eutIbrvLnG5faTCUfCDkUQRji4RJOxBQqahDIheqeno=;
 b=JpLb0cjxwDYbTo0KcIXfIX+EmS5k9UResNt58rqo+8zu59RvCjoTxhTdmwvBq0+Qdk
 y9vYD0sJzKXUaLwxMBndpoTuKlyhlwVLLZy6ppB9RrlVRGNdclHsXsV1aDyJQRP5Ug1F
 9jIZxISysvxWiMqBkUPEPS2pvsEIXF4ERoAqbW444dFyREQjl1ZRJBu7pj4SvGSb72uA
 a0iwUO+UJDSwjrrVGSHJMS+tPmOnhORGx1b5QT+8bDB0u8RxEl2SLIB5bNCQA3sarN3F
 aFG+p3YuRmbInls9bN6TQM2Y9BVAvJD3trT8u+qe0jU9tBjwWDTNkP2hvUd9ti/Qvq66
 2Y6A==
X-Gm-Message-State: AFuF++kiohz0vKft7ctwJdMJYUVYaGXtO0R+5xWNI0ZXwX+udk2H+EBu
 75rLIHY5cyuDOeYIUVe7FOXgR2ct6D8uy2+E3xyFrjImR0x2YYGn7NuoYX+DOz1Hfsw=
X-Gm-Gg: AYBFou1Hff7lFlSHwyZp3ihEzRYxFt36AJRcq9AjciWflBq0aPafm0MwmANQq/Thgjh
 Tb344Up+MQY4CvCVMbvNxsDqHuA8vTKY6sCwEROcTBgoPvBI9rkG3i+Q1CnrGwoBpwXKcmlS31h
 nSR5OM/0fDVXov/rXjiSdLZRbB8uY6GcwIlJoGx9ysRCrvvwkocIr2AqLVvDI8Z2eb9qEuAp2WR
 kZtumB6vkwUrNl02WTJ+3uY/RvjkrFF6MkqeLiKJqFDRigmb1cFKnwhPxIH6RV7WSQesk2SouFU
 Hj9iSvB33FWpwPGgEohOdd5xlErOcFF7yo9whI4K1EOEJw464admozWYag1z/MrrfbMYNp8vxXw
 pxVpoqejSbHTuVlb4K6RGBcv/D5fLM5D79OLs8VbhZeX0o+Otcw0DnAr2br3ZLIN8BosIOZrlNU
 3oB3LIK1GnWb0o6j2WIDaKq+hGdVSHhov7d+iOn1P0FHLUt23nOZL2Z33fBbG4JRTaRMNc0l+B5
 tABBTF9cA1T9vD03Pfv0w1izwRgLIldCFRozrtt
X-Received: by 2002:a17:90b:3912:b0:398:c724:1bb1 with SMTP id
 98e67ed59e1d1-39b26101524mr32701452a91.8.1788800833675; 
 Mon, 07 Sep 2026 10:07:13 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08d0d7e8sm29227590a91.16.2026.09.07.10.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:07:13 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:07:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Bruce
 Richardson <bruce.richardson@intel.com>
Subject: Re: [RFC PATCH] mempool: no cache size limit
Message-ID: <20260907100705.105ef931@phoenix.local>
In-Reply-To: <20260907120605.969197-1-mb@smartsharesystems.com>
References: <20260907120605.969197-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon,  7 Sep 2026 12:06:05 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Replaced the object array of fixed size in the per-lcore local cache
> with a dynamically sized array, thereby making the
> RTE_MEMPOOL_CACHE_MAX_SIZE superfluous.
> For faster indexing into the per-lcore array of caches, pre-calculate
> the size (in bytes) of the per-lcore local cache.
>=20
> Also swapped the position of the private data and the local caches;
> the private data now are positioned before the local caches, instead
> of after.
> Positioning the private data directly after the mempool header reduces
> getting the private data pointer to simply adding a constant.
> The local caches are accessed by dereferencing a pointer anyway, so the
> performance for accessing these is unaffected by moving their position.
>=20
> Comments, please?
>=20
> We should probably keep RTE_MEMPOOL_CACHE_MAX_SIZE in rte_config.h for
> DPDK 26.11, and deprecate it as obsolete.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Maybe have a very large upper bound to prevent bugs from broken programs?
