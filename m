Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C272FC982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 15:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDC61427E3;
	Thu, 17 Sep 2026 17:32:57 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id B2038427B2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 17:32:56 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so872534a91.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789659176; x=1790263976; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ZC2sakx23j0x4IKxDQBDCFHCIpGg8JqlDgJnh6n/gU=;
 b=BN6leMKFh6DiDVrByV/18v92FfHjjsBy0fY46e27sGSEQaJ0d8jpumf4bNzJuXmADO
 JB8W7A7pVAy2Otn++p/nQ+ZgBKpKOI+DAbBkEnOnbTaG3Migwsamv7r9bM2rdtfTEgdY
 /3fngF75fbrLG/4lUz5heF9nW+FVfE2Y8wJbB/bM3cwyDZW0rnW9cdlv0aTGpvX6krxC
 qHtwzhVuq6ztoLO3sozTSNEZ/zrsVY6srbIdS8LI/s6EDSikOh9jbXOO711+fXGa6FtZ
 qm5GrVEKbwsayyNeHzAyjevAhCAZH5cJE/KxuQebLebmIUTDAY7vfDFhIpDauciXRlaR
 GFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789659176; x=1790263976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ZC2sakx23j0x4IKxDQBDCFHCIpGg8JqlDgJnh6n/gU=;
 b=p8I38m0YFHhN1WFpPp+F/yRKbMTr2ivatyH+kRcwWuHojiAE+TIVtwWm4kX9kpbAJX
 bAFSNOEYFJiShfbIq7xzaoo8VSM4wpmOPuI5C6r9kPADZ08s0y6k2DUHeY5JNQjniOKL
 R88MVDk/m0FMq95KK18F9layLs6oYvIsJTsI3ZS+naPpw1QwENvRVrYKIqkvyYNYQqiB
 qBSP6wUmMGeWsPdtcoQqzOKEMqyoC4milhSpqHYGo2zqSWSqLnEDQeA+TZe5Ktes53QU
 xhHGPwynKiuK01eZiG3KlcIcf4HkWLQCOKh0U/hccl5Ahq1m04tOAU5tiukLChpAi/XD
 l30w==
X-Gm-Message-State: AFuF++kL5usiztK8InFqSxoPw1nMvg24m40Pz3LqBJZpDHtrbm3xr5L1
 H1KxPsqDaFmyZI2Xo69S9wH3oWQ9n618d6c55+9eIwwYl7+o6uAOmKCF44aZ7w==
X-Gm-Gg: AYBFou3Ob8Iq3EYg4o/IgUQtrBR93R3+yF82HbQM3PKbdJ5JQ2kD0VDefbjPdN32kta
 t4tl0z/4TtuuuEFav9LZuimHF1GiXYTpUfwfH0RuaF3YJDuDPZlOeOl4YzHbBrFVMiYTcvVespn
 rvGMM5IhhTat/xO7ziIWAF1vhsp7YyoD3aLE5e7+MILM73gjDCcUvMuETRQdzyQRioLwbtt+HMF
 zfDNZrYWUj4mEmYZNlg1cnKwMscVT1bgCxj2zzRf+DdINhYORkF/8KCw8DzAoB8F0NUakSUF5yU
 VKi/LfbCQzjKWIwYV+KKjo1koU5pWxLkkC2j+538M/KWY8/hTIcOmbi+jjGg8jEPuvHbarrCLC9
 TTofUWSlJapYlILt5eP0vJQFgN7QdWXltUVtlD5mD9gzfI4p/tEf2cg4zGmCVFoXQcwwysBwVHf
 P9eqHiJEsBqfCEYq5NzZnGlVcAV9Myz17Hb2ljqHG/LGfULijY+IEaG6ITuQDEgSIo/juqjvmOO
 j+uphM=
X-Received: by 2002:a17:90b:4d0e:b0:39e:4c7e:f044 with SMTP id
 98e67ed59e1d1-39e4c7efb06mr1214791a91.33.1789659175480; 
 Thu, 17 Sep 2026 08:32:55 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35df6112sm5730350a91.7.2026.09.17.08.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 08:32:54 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: 
Cc: dev@dpdk.org, stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH v3 0/3] net/txgbe: fix flow create errors
Date: Thu, 17 Sep 2026 23:32:39 +0800
Message-ID: <20260917153242.29315-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916131106.105667-1-zhtfdev@gmail.com>
References: <20260916131106.105667-1-zhtfdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v3:
- reject mask-only FDIR before programming the global mask
- log flex offset mismatch
- no code change in 1/3 and 2/3

v2:
- split L2 tunnel add-failure goto out into its own patch
- allocate FDIR object before installing the global mask
- add Fixes tag for the VF FDIR path
- set -EINVAL on remaining FDIR goto out paths with bad ret
- use struct assignment instead of rte_memcpy for filter copies

1/3 fix L2 tunnel error on flow create
2/3 fix leak of filters on flow create
3/3 fix FDIR error handling on flow create

Zhang Tengfei (3):
  net/txgbe: fix L2 tunnel error on flow create
  net/txgbe: fix leak of filters on flow create
  net/txgbe: fix FDIR error handling on flow create

 drivers/net/txgbe/txgbe_flow.c | 266 +++++++++++++++++----------------
 1 file changed, 140 insertions(+), 126 deletions(-)

-- 
2.53.0

