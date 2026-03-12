Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C1106ACCD
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 17:03:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF00E40662;
	Thu, 12 Mar 2026 18:03:21 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id EC94140275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 18:03:20 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d743cd9e5bso869170a34.2
 for <dev@dpdk.org>; Thu, 12 Mar 2026 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773335000;
 x=1773939800; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVwtzATwz/9iRlT/3K0VAxf9faVB6PxwjVdiJTv9XEo=;
 b=vGLXiw+7ZoSSorufpcnFsoYYhTiTjtZC+haRTlh99Qop7OvfKbDijKwSVyZeMy7Qhx
 JLHSGizdbyUrCPqAhiQrT+khj9pBBHEC3evlQ8OUNc8IS1C06b3L94yUcPaeHqPupBPD
 t0MXe69pZuzmDPHmDNgBNbn+hoX1AxucSy2C1cPcvLE2K9zCv3TgpFIOxSEVmgRSdYA+
 8V9leNVKf3VZdDItUsc8Vs93xhbzqPvDwwtKrHbY4CQA9sHeSo4M0kGMe5JO3/EAj1bJ
 wpY5/iv81a4xFo4Y50TFM5sDSCnA/It/uVkIUfZsS7nIM+PqtZL6OqiPvVrb3EAIH4xd
 0ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773335000; x=1773939800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jVwtzATwz/9iRlT/3K0VAxf9faVB6PxwjVdiJTv9XEo=;
 b=wmQ9/K1xSWwCPtzgs05FtlsKiLE1msxKbWOkW1D+KsegwLTUltehly1MBz7zDGUgGG
 j2HC4rCSDFPoKnA3tMuAExHV5EKeE47RWXnuGxvBGloAW8+w+pCgbOJEEs/nsKcHgM6M
 qnwhUQ2QELifFHFGBX4C0hElBmIPeNER49QdUTLQRXwDYEhbyD8WOVFA3ToLJN2Tek54
 kkCfPwEMei0RJbt6Sw8l2eTPQ9ghq6aP7z9h5NSwgQbTp4n7QeYcU1F59xo9qVYQGsAc
 DG3fGjheLRr7OS+T85Xg4Wh7MRYWIWeatsefQ6SzM8djw1cLvN51AY5JCmIVkPvUvN/P
 ZTkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmRa+m411rPuI4BSJ7vSKpZuIV9QHbDdHXpd1mdZ5GA0LQKiZzQZIy+d5PvCwmeOvrN9g=@dpdk.org
X-Gm-Message-State: AOJu0YzQ+8GmHLkzSXsnERuqF2TRDPB3ifN5p7+D4eh39LstRx69dBIC
 /LKa/hvGKln4mn2XymJNEYEPhfwyRhz3gYmcJz0Ck+y8/ch0n1TgFryFWAwnr1bPbPo=
X-Gm-Gg: ATEYQzxEz+8Rl/xRhCSXOWufrhvXtAP1LB+M9rmBiHOMsMrh6/9AHpUJquuTjczIMGm
 qrI8rQ9DkJkEcOiFwc0T+EPTldwbc51fqLy9fAjzdCOPQbQ3M4QVNS9hhqdvXSKGcXR1Hqf068P
 /bcWy4ZsE4hOVKwHaKmLlTeyTbcHvCzhY9e83DBfG++/a7G0Ps8dHEXR/meF3pYKJEOZ0iSPhkm
 Zya2nlgV5qPKMD82UTVBKKL2HXffoy+qTEc9JtdLZdjqPN8VBzfFLynb2zfiIeL2EynOyZ97jvp
 MPszCHVJOXO46OKp60L2xWes412XoyitQBFSFrFVHUziqGLglf3wZqLL434qcDwiU6VqxZAabYD
 4vhfx9VHLFG1Ta+8Rj9Za+9cKAMKLTuT8vyBhMrMk4+eYlcg8ydXw1At8PqE4pMDN8Wj7ZvfSf8
 T5sl4CEsy3usIrVNAPM/qI1ZrtcnrvFg3PXio=
X-Received: by 2002:a05:6830:7301:b0:7d7:7a70:cf5e with SMTP id
 46e09a7af769-7d782603d1emr52127a34.28.1773335000139; 
 Thu, 12 Mar 2026 10:03:20 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm4346858a34.20.2026.03.12.10.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 10:03:19 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:03:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Kevin Traynor <ktraynor@redhat.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH 3/4] app/testpmd: check for no arguments
Message-ID: <20260312100317.5b06a849@phoenix.local>
In-Reply-To: <51026e44-1045-47ef-add5-7a98c3ad4eac@huawei.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-4-ktraynor@redhat.com>
 <51026e44-1045-47ef-add5-7a98c3ad4eac@huawei.com>
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

On Thu, 12 Mar 2026 20:37:42 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> Hi Kevin,
> 
> On 3/12/2026 6:36 PM, Kevin Traynor wrote:
> > For the case where token is NULL, there are no arguments
> > and split_str[0] is used uninitialized.  
> 
> In which case the token is NULL, if there are no arguments, the cmdline's
> callback won't be invoke.
> 
> Thanks

It still maybe possible to get there with an empty string ""
which would evaluate to no arguments?
