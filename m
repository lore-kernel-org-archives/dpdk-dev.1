Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16170C982EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 12:44:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16D8A40E48;
	Mon, 21 Sep 2026 14:44:39 +0200 (CEST)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by mails.dpdk.org (Postfix) with ESMTP id A66BE4021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 14:44:37 +0200 (CEST)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f56039dso381632966b.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789994677; x=1790599477; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=di/XUu7VbFOXX38g/4+R5j2k0zVO3/N1UeycroM8RUw=;
 b=AdssvGvUBy6MhiOmVHufIH68Z+0t/MSVMvFwHSZlFwgpkfuGu7TQQq+CA+T4eoMZkM
 rImN6Zi05g+hqK2QjEkDgJ8F9605agAE9BS1/S2XRkz7K/GjCaDObXQP7UECB/ZXmt9K
 T4CeOJbrn3UHVZgafe27sEQotIMKJD4ge/423vgjf1AHyidA594gUwzgreQX/yVirioM
 gZyWnxfjl7k5d+WzeegWFJw5+lB8swYD5gmjeuBaGktE5myXIZXsbBGYxnKf6oRL6BDM
 fPiKs46N0seX8p3TMcldoKlMHd0rG0RLh3B/H3JkXjRP4IHjrKhTwIXqChYckrgyCrh6
 bvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789994677; x=1790599477;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=di/XUu7VbFOXX38g/4+R5j2k0zVO3/N1UeycroM8RUw=;
 b=Db4f4bjvAwFXvAG7gRsT35I3PmkXwQhrQKuqR8e9tDUGRntTmpDJIs4a7wkEFA+uRZ
 unI2g3mBqvyy0daKSy3uphpxDDjDVPOj1tNVmv612/R6+UVOhhFQMM4r/FDF84PkjQWh
 CjtGHNBLFWwdOf1vKxcEax7QRh9JrYh3vIgjz5Dzwh30ThrpghtDiU5Fp1Tpxs0bE7Gm
 8a30M4H+MnqJ3GANdQ87wnmw+zPV1j2jk48SK2ukoPIvGD17gxYxyo4paL1qApA5hV2V
 BkCEcwQ1AEwfPr2S69GIkj01NxuErbyPACzdAeYz+x11Ue2CM/EBPtC64vfp5jO6Wu/C
 v4Lg==
X-Gm-Message-State: AFuF++leBvZ6Ef58DxK+qR8AzfzKKNI1Dq9oIXMkdQoWVu/4tz6ASzTZ
 Omq63MascVkWwyJUEqWM8+hVogTB6Nilz0L4aUpQlLbADKZPFxqTc+NBZaK5wHWs
X-Gm-Gg: AYBFou2tMRE/gLfwH792x32FRZ3uQ2CgwztxVOGD2V14olziUGcJVHNiEdHpr0gLODC
 xtJYP/cAOpdq2LYqHgYJkckQVV1RIEymLTX0VqBHIjTWHN8QYiAMAYcB4mkzekqY/ZH46akfDiR
 yJuMdc7FIKnecO9pE79qgBjPy17ZCtZrQQxIGrvfS7L0vOxnmLtnEwt7kcQyWU7LBDjaGBFi7rD
 EkQoXnQ5X+WLRYKQ0lXVSicmP/x+mK6N/Y0Cp+y0peQuSMFQAWeZZVD9494yR4vJYBW7nw1M/Z4
 VUvExEKkzo9x9dmDtq6KFZ0DFslGb6qWRZibXpbt8ZsgiJokw6WVaOcVHgz2m7xuv+WmSapHSsj
 0KaUae6j1zUc75ssSQOSVczG70sECYH5PouypWjlN0wwAEYHfAHNc0bsfo8kt3dGIMkGs9oxkMO
 g/bJVqZjNJ+LLAdsVKauFAuPw23yhVSqgoelBF6Sp2Hs52u10czPvUx43aioNRACOUXQukWw==
X-Received: by 2002:a17:906:eec8:b0:c26:19de:912a with SMTP id
 a640c23a62f3a-c2a15b3402amr942946866b.29.1789994677051; 
 Mon, 21 Sep 2026 05:44:37 -0700 (PDT)
Received: from [192.168.103.32] ([89.101.57.120])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a352381c2sm305324766b.7.2026.09.21.05.44.36
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 05:44:36 -0700 (PDT)
Message-ID: <3cee10d8-d8ca-4eb4-802f-75f62298ccd6@gmail.com>
Date: Mon, 21 Sep 2026 13:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] test/bpf: remove redundant library guard
To: dev@dpdk.org
References: <20260805090350.37661-1-marat.khalili@huawei.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260805090350.37661-1-marat.khalili@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Recheck-request: loongarch-unit-testing

