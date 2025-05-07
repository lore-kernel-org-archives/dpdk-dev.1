Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D0AC3ABC0
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 15:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D34444025D;
	Wed,  7 May 2025 17:32:58 +0200 (CEST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51]) by mails.dpdk.org (Postfix) with ESMTP id 7244B4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 17:32:57 +0200 (CEST)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-54fbd1ba65dso230168e87.0
 for <dev@dpdk.org>; Wed, 07 May 2025 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746631977; x=1747236777; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7carhqy2x8dN4x7eGdDXrIm/W9EzQrRhTBFVpj+wiio=;
 b=Ua4qk6ExmwdOQhYscQAVODc9mmEW/+Nf7rddxnSjOA91IMWK8bjiIx/fDdRdy1ZIqz
 bRaUFkVsP0wW8twlPV4CAf0MbV6nz7QxQZJtDsBJFWlpeULFOatOF8e56nN4jQdw9K1P
 L1qRCyM0S73IOcd1VC8PKPbb9C9RMP42v+1Gdw5imPCkzpwRUbdHJu3tClld1nlO+vtY
 Y/QiEGW9KXe5fLo0IPCEGuiwic33lg00XhuLN62rtiq5TW0arShpaM3pFwUgXK+Lbe8F
 hj2EYmIVnaYynoBTfSaLZ0f0Y044pbIe+ul6NaN5RlNPzF6mtBuzDRNFLyMvk2ipM8j3
 smjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746631977; x=1747236777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7carhqy2x8dN4x7eGdDXrIm/W9EzQrRhTBFVpj+wiio=;
 b=vqvAMA6kYK1baI4jJoovbhFNFFxMTHcLdzrBoID0p3Ysp7CHGAdII3ECj97L7KmwGX
 T/+O3ZTPzqYRFaUSwTAVMMfn9X/GccEdWhKaoVGdfhudCuBLZkYdqrbHBhUuk25Om+nw
 rckgVc92lPSHGEjetm2M2d3deSyEHloaMYUsMcGbjFAiUzJx4QRLUqOJjphfcyBxD64o
 3D6UrVjJI/085JcveAvWiSI2orCWEozNKWQCfuS09k1LqrHDCO18arYB42qJCdW6vuyP
 9f+zu1DktxNNmj6m6IVRN2qAOXaxK3VupwSw5sJWAidGIeEFPnWjYOCLwj9xYNeywV+T
 Stzg==
X-Gm-Message-State: AOJu0YzITjjzvFJOSklLht1IurfJO6YaVqMsFP5ZHEJDeZVIanIOJ/Uy
 vMK46on5+LTYTMzUQz81dP3prQD88mx7mFb1kIEfbnfZAZMh9fqF
X-Gm-Gg: ASbGncuR2iLkkgUH9xKFus1niMVlqyxpO4EXTH9HY7A6VCkmLp6J70hmgUntM3EXGdF
 SR+fV5+YwkvFkp5r7MqFKCdTd4cL7y7iM/xc6jhbDfQYsuX7QdzcecvqOaQazkEIq8YRUalwbK1
 M6yKZnM6rf8Q+8q7RJnFjYFeJiFjBpoI4+5cwqW17bpLjAPY11TVS8AMLqKqEJ2WwZevmzZVStL
 rAcb5nFaHZS05OgrBD4qO/nnLBW8zEm5G8okXuiwSG+zxgnOEabTXxPTCnHeyIjd2H5fmowpX0s
 oP9XKeMqaVTA4ALA7xf5JHx46wnETUbl5Bn2eJFsR+Y=
X-Google-Smtp-Source: AGHT+IHYp6YPQJtzAesVQMPZik87NpzLuxbpPCLA2F0HuDsek66hOXqArIcqcte2GCo9MCk2Rd34/A==
X-Received: by 2002:a05:6512:3e1e:b0:54e:a2f8:73da with SMTP id
 2adb3069b0e04-54fb95fb807mr1384051e87.18.1746631976425; 
 Wed, 07 May 2025 08:32:56 -0700 (PDT)
Received: from [10.8.1.3] ([91.186.217.41]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ea94b1909sm2363129e87.28.2025.05.07.08.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 08:32:55 -0700 (PDT)
Message-ID: <1cc9e0cc-70c9-4829-88d3-df41060e91a5@gmail.com>
Date: Wed, 7 May 2025 18:32:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-2-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <1746627671-28659-2-git-send-email-andremue@linux.microsoft.com>
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

Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
