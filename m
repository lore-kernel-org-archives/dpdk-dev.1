Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD59C44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:41:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1231842DA3;
	Wed, 21 Jan 2026 18:41:29 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 9E5A240261
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:41:27 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43591b55727so60618f8f.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769017287;
 x=1769622087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pnrGRS/ptPw7Mb+/MMkbyFTJzRXyDRy6NKa3Sey36k=;
 b=muPL/jjOl7Bs+wW76pXYWjdAtYwt31l6v86aRTZVgK2NU9yBNL5dNWy2xrfS9hWrtq
 4UG33dEYPXmQb8+jWVhVBPQIDnrY7WKkEwwbYeQxWowoKou5VCjwJgkNLRyFG8NioM3s
 5oLUctQ4zJX42Ndz3xIToysFFPEucXSKLmnV63csabQFNeSD3sJRD8890DT8abEl0k/S
 krqZCmMYOELFXro/5cD+VN70uv1+5XAHGsvx7q0RrOdOiu3rwKYeZ/y8uiYZv4VvfJJl
 FV36pkSMo8l4gcuhkJKmURVbK4eEXkp4KNFkyeUcDSIjjYxXpW535Gc2klNOsnOPOtCm
 DizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769017287; x=1769622087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7pnrGRS/ptPw7Mb+/MMkbyFTJzRXyDRy6NKa3Sey36k=;
 b=BF05jFWA/bSKsgxZXYDroO9TBiP9ToJA21jEbYrKOXqQIPzEyFC70ktXfk4NkgbKja
 yLGMD050gKMgliZUg/tQuw/A6WeJWg5iwZhLi6+DSskRb3FKgXpmT20kW1KmtLFGdBmB
 hfmSCGWNLlAf/a54TB9fy0tHpy7mFnPHHYOi/yScdFhbia9FrkcSVctfNG3uYvaSiiIV
 g9f4INuaL7Hp1Rv5L1wMwKcZbRAilKO4E2FdtgSq2y6R9szRPeQ+f7FPafz1aeGqbmXd
 SatqNtdI88yqDixx7STxaLYj00Jy+yEFXshnQRQqChEMmErnO2Rb6x9NiMlVFloZuN/M
 28lg==
X-Gm-Message-State: AOJu0YzS89QFbCBYmH8lYGnlXl/QGvTZsmIGhiGeWnUKHUELXLtmSf5H
 6rw8BonV6pbJMrFH42kTidz3NoksllPeNcRuF+8yKJn9jB5FZshe+cGW86btHrB5QsgZiZkx8Sj
 roprg
X-Gm-Gg: AZuq6aIhldi3WFlUPdeIaWhDh+4x9fGkPCKxFLCQEBHAUtDUmKulZamgLTYGnjTW2e/
 N27S5rBgVkxo1T1A0yIJKI7B+9Oarq0EZwdnRTAieUFa1aQOqgFnQwnZrXgy5Lr7pP3/bfWq0t7
 XeOAAMBs5PhS5oQ//Cytgbbw84mAsv15foHeuPG/s3lIhPRlVzZKxMnPRysX39FjkOs3beWHik4
 ogTs9QHp4WB5WhjHA4S8jT8jaPo8T2oNLpnlMM96W+QhV5tK0j9Oqt/he+oXbqlEl1zxsqTm/u2
 oqW1E+fp0eIkLUO6fJiyJJM93vmOOT2Kb6gN1Z4l3nBcB2fvlwMGlAcWZRRFNDrXpG7oKurFvFa
 gHoRx/qMzhoC3IzlUks95Xm+c8geWoipnUP/dd+TypIsCD3xFsxZ846UXSXS2WOv/JB0an7iRMq
 L/rgJaMDuuwfe18F/z1f5yuwXRD24xZe7o+ksSOHSDZ92QBPF4K4o7
X-Received: by 2002:a5d:64e7:0:b0:430:f494:6a9c with SMTP id
 ffacd0b85a97d-4356a039be4mr25154900f8f.17.1769017287201; 
 Wed, 21 Jan 2026 09:41:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435966322a2sm9196541f8f.38.2026.01.21.09.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:41:26 -0800 (PST)
Date: Wed, 21 Jan 2026 09:41:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 8/8] doc/nfb: cleanup and update guide
Message-ID: <20260121094122.35f9af9e@phoenix.local>
In-Reply-To: <20260121170333.272985-9-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260121170333.272985-1-spinler@cesnet.cz>
 <20260121170333.272985-9-spinler@cesnet.cz>
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

On Wed, 21 Jan 2026 18:03:33 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> changes:
> - overall cleanup
> - added list of up-to-date cards and links for firmware download
> - updated description of the port argument
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>

AI review nit.

**Minor issue:** The commit body format is unusual:
```
changes:
- overall cleanup
- added list of up-to-date cards...
```
Convention is to use prose in imperative mood. Suggest rewording to something like:
```
Clean up documentation and update the guide with:
- Current card list with firmware download links
- Updated port argument description
