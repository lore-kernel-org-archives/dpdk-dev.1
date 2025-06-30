Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2962DC83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:23:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 778ED402A5;
	Mon, 30 Jun 2025 17:23:21 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 0632040291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 17:23:20 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7d40874b399so196666385a.2
 for <dev@dpdk.org>; Mon, 30 Jun 2025 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751296999;
 x=1751901799; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/O8DcUnH+VanVSrmfx5fn5aNbvZIp+PcK6O3t3e0f+s=;
 b=ERNoISQkztGg70LVQkXt4sdz87WkQvEoHos1s2RJpNyZOXN8a/0EVJdlS1yH1QOOuX
 C1cdN56l6wEMSGl00rXDx61fMtn/mbbi/iOgNj9jBCfUlUgoK8dPux6OZ4OmueWpVZkw
 QZH3WF18eAl631Sm1BRXmdoLaOY84M1R+k7/vRYZQfoJVKboV2IhA/JefiGsDEKHSsVW
 VHr6TaHuMsiw+Hk96decwCY4mOp2dL/YnebmXyu73kKT5i+/RFeYchfI116S5T7B+BVb
 FMxTcUkgDYyHtY9reLAXcQzGG/mT9S2O6ACyxWVIsGy11uadn1E8oXhOS+qKc5zCNyEs
 NbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296999; x=1751901799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/O8DcUnH+VanVSrmfx5fn5aNbvZIp+PcK6O3t3e0f+s=;
 b=JZdALZt5v4+buEH7eKP6yWqvfsQWfw/HMaUtGC8xgL2GeuW2GTjFpl9LY6jaqQHOVI
 L3WI46BKB7noBYb8urG4m62I1gjesIaPolMlo7WBDRmplD32YYEzY74yiGDORG/9mK84
 SoOaK90PB3ljz+Bw28UP36KVFYu9FTLDk6Mr4LKhirgUiL7nLsistg8SO81bs9j6g4zB
 BS5zJZeRl5vN7AeIUWaN6bFUzWjHtsvhFbGvX/ZjtaDsszUlkpo7OSeMpW7U3gtRu1Rm
 JcDrIqffsrchq8P0Xv6QBRxko7oacPUwo5/npG63is7f39zjHg0PlNDpOjdB7b02Y6VG
 xIHQ==
X-Gm-Message-State: AOJu0YykBHPgMB4ZtzXkuRxeooya5NYNd3PMnDIS0N2QyTY91Pd9ge30
 V1815xrZscWounMEmkdqNDTWyG+WYgG91aUCfqaHxEeHwTcKgYNoTMMKvgjHVvYvCMrN97U2pcH
 kT8G7
X-Gm-Gg: ASbGncuugL29XQkvtrPuvsuW+QtFEZEACxVsoCWNzyuA18JuBSSBxnJgDnMuUmVXTDy
 e/4raF2ttz6PcZHCyuzHDjUc71tgtDaAijePvhHSzCTUpktUFlcdYLcd2aynpaERP2Ys4cQRffj
 rm2eR0EfKRVgXszBSr1M1FaD7fJn8J7rzak5DbRGUjncud4OSWaa5m0UAMCJl0+I2xkng0uN/Z8
 PDKEtrchv6+QLNU3T/Tonjn1tVq6F8K5xzI1+AWkvbriVuEAYLgOUMFxC3dZjAJRePMCTcltrcv
 R/tbsCM8obJdDdnc1aLt9opy/EPM5xr7Ii3jCu/vSDbY6b7gdJ85jFBom3zQpB3HJmP6ABTJhVe
 hO3Cu2b41F55sBtnCnBUWmHWerUiK3Fc/Ua6aEgY=
X-Google-Smtp-Source: AGHT+IFgUii6HDgp+XGYHdFxPlaNJ/4HsvYrFtZssuq9yE+kb9QY6Jqj6+JHdOg8k+YmA5kn8SVXew==
X-Received: by 2002:a05:620a:288c:b0:7d4:3d40:4a with SMTP id
 af79cd13be357-7d4439b8e6fmr1632471085a.51.1751296999155; 
 Mon, 30 Jun 2025 08:23:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443150adesm614056185a.26.2025.06.30.08.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:23:19 -0700 (PDT)
Date: Mon, 30 Jun 2025 08:23:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <fengchengwen@huawei.com>
Subject: Re: [PATCH v2] test/argparse: change initialization to workaround LTO
Message-ID: <20250630082316.689de55a@hermes.local>
In-Reply-To: <aGKrNT8h5FGVrBjH@bricha3-mobl1.ger.corp.intel.com>
References: <20250627162305.340042-1-stephen@networkplumber.org>
 <20250630145934.56969-1-stephen@networkplumber.org>
 <aGKrNT8h5FGVrBjH@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 30 Jun 2025 16:20:21 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> We should consider either making this a "do { } while" loop or adding the
> termination condition to the "for" loop statement as normal. For example:
> 
> 	unsigned int i = 0;
> 
> 	obj = backup;
> 	do {
> 		obj.args[i] = backup.args[i];
> 	} while (backup.args[++i].name_long != NULL);
> 
> or else:
> 
> 	obj = backup;
> 	for (i = 0; backup.args[i].name_long != NULL; i++)
> 		obj.args[i] = backup.args[i];
> 	obj.args[i] = ARGPARSE_ARG_END();
> 
> I'd tend toward the second, myself, but what is in your patch above is fine
> as-is too.

Agree with one of the two is more readable.
I kind of wanted to keep what original code was doing.
