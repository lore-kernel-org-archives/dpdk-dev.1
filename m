Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F9DC5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:34:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C6B940270;
	Mon, 24 Aug 2026 17:34:15 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 74238400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 17:34:14 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84f77cc7302so1295766b3a.3
 for <dev@dpdk.org>; Mon, 24 Aug 2026 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787585653;
 x=1788190453; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6HjZkB3UaUXnK22XZQKuMYP7AFcc5ezD4K//6mWGFxE=;
 b=VXr2grBo6hOt7VXTV06UdfI84FknHJ25zfCviFaRJYCXhCup/Z1RN1iv1M0j151/yh
 xcxilM6FFDz8dwarY6yYPgC4cKjeX7B4LObyyNiMUXOsV/G/sYPnX8dTkz8dBDBg6/jw
 RyYS1BwJqH5wS1yInG0o3+pW86jRMx8G5/Vo4c6KMz/TSjyhk+D0/KPkUIPnyJLa3Igo
 XphfLw2yWNz9DZGxyy49fqT9jBPp8mu6KD4jXwxKi/+kVHMY0Xe17qcx7E5wNMwaFeyb
 aNfz2x7uOD5HdmCR9mZmSLUA55Uu7U5yirme8JQYEg9E+p365d8m+m0OVPKSSEFF7eyx
 lYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585653; x=1788190453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6HjZkB3UaUXnK22XZQKuMYP7AFcc5ezD4K//6mWGFxE=;
 b=DxLIFW9QQxr48FLFgkjJfpASVi7Iojh5mN9OfwZV8JiuSKQyDj0/h8W1xqXlncoP3M
 slcS1KOiDK4Dm5arG2zMT1lKEHW1CtMrMnbJRIOYDSemOPzDtTTaHdS7Trv5rXDlTCY7
 z5SlY9JL2OgbPT/2Va0hSHGlswnLNhEzhhYzMra4FP9IfnF5wC+aslG5cuH2jKOm6kg2
 ix1MeXAe7w1200BcueF23EYwSCXtsT40EXouQ89tPT8+zKT7bAmwvdns8kM8rCz3o7Qe
 1UHmOn+T5weSHOKqSr2wyn49lCfh6koIRzh6p9AzfplUqkAMjkd2LeTrPO8x3RA/f8Zy
 NLqg==
X-Gm-Message-State: AFuF++msBGbVhdWdeLSD+hDhTBZ7oR0qiV2w/N9nLRGfuKyA5wlwZMc+
 5p/ytMrktMT3mb9QI0fwM430K/qNPKESkGBZ+cuubDn9wkR1pnGHZEYZBGobap3amvEJOVl0Sor
 zDlPQ
X-Gm-Gg: AR+sD11jmITEtQhhAF+avCWF5RKPTWkNV4IIL+KnoMAder97/6ElhWnOP3tc5hMKt+f
 sDZFnPWSZVeHmdRnCe0ciBg1VNQXBYv1+fL4YbNjMFQoEG0RbmGRxLchCj5Xqf4dgmFyI/1wOsD
 FTzOXQOuz5Fx572gULTg3FjT5ufKSEQsfxt0c+4igyqRa0l/PZBYcArmuBqa9ipAoLx1zm8wIvL
 J4jnWqlDeR9HesB7lJTGsPSfnI0ClrXmo/2eoLzuhIrVK7c9RVX4zm65PT8lgCNzZtGR6wLkGWv
 rcOU2g3aSQ8VE/BK6G+GMZ9p+8Y0iLn5HDBe8rPTCpD2iD7BDppmoX9sv553Ajl8PGSNlMJOZdB
 WXof0TiVD8YkUJ3GUSeDYVYkyyOyMHZMW0proPSWDheRgI8AY2qmRb13lqF2Io76PhXCyZapquL
 5zkE6AwKoIKatF/cWzVI9k6aYVcphFaMvLOIOygQBPTFYzy0uJl4eLCOpu/IYIDNwak6MJFPQn0
 wabDZM2Vhx3++4yDQggUd5rZbIswIH9sjgJ65s1
X-Received: by 2002:a05:6a21:1fc8:b0:3cc:9316:cad3 with SMTP id
 adf61e73a8af0-3cd2fa367c0mr55341881637.0.1787585653504; 
 Mon, 24 Aug 2026 08:34:13 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc199daee0bsm1144950a12.2.2026.08.24.08.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:34:13 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:34:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 2/2] net/sfc: provide cached dev info to use in
 secondary process
Message-ID: <20260824083403.6561e6cc@phoenix.local>
In-Reply-To: <20260822000646.12718-3-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
 <20260822000646.12718-1-ivan.malov@arknetworks.am>
 <20260822000646.12718-3-ivan.malov@arknetworks.am>
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

On Sat, 22 Aug 2026 04:06:46 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Secondary process support in the 'test-pmd' application now requires that
> the driver expose the 'dev_infos_get' method within that context. Use the
> cached dev info from the primary process in order to meet the requirement.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
> ---

Looks like AI does see one valid race in the use of the cache.
Sorry for the word salad. It is hard to get it be concise.

Review of [PATCH v3 2/2] net/sfc: provide cached dev info to use in
secondary process

Error: the driver sets RTE_PCI_DRV_PROBE_AGAIN, and re-probe of an
existing device (to add representors) runs this code again when the
ethdev already exists, dev_info_cache_is_valid is already true, and
secondary processes are attached and may call dev_infos_get at any
time.  rte_eth_dev_info_get() begins by memset()ing the structure it
is given, which here is the shared cache, so it is zeroed and then
refilled while the flag stays true; a secondary reading during that
window gets zeroed or partially refilled dev info reported as valid.
This is not the initial-fill race raised on v2 -- there the release
store after the fill does order things correctly.

Fix: only fill the cache when the ethdev was just created, since the
values do not change between probes of the same device.  dev_created
is already in scope:

	if (dev_created && rte_eal_process_type() == RTE_PROC_PRIMARY) {
