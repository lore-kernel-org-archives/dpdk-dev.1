Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21CAC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 21:36:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 090B1402DD;
	Wed,  5 Mar 2025 22:36:27 +0100 (CET)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 21D2640279
 for <dev@dpdk.org>; Wed,  5 Mar 2025 22:36:26 +0100 (CET)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-6fd80f30ba5so29723767b3.3
 for <dev@dpdk.org>; Wed, 05 Mar 2025 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741210585; x=1741815385; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=LuI/fuIjqYvl4OGc7M8vEmSPcG0p4iXBdR8u6tom2RmE5/drRKG6l893idv2G7n9jb
 KCYZC4AmAGvPG9JZZ44cva+t0Fg8DxquC4OqabprGR7X1AB/Si76MuzcILSHe3QmqAB6
 crPKFkMGO8qdY4154wphmIABF8cIoQG5C81Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741210585; x=1741815385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=Rkboml7Qs9Gx82Uxd5zvwaA1TAZnnlc2w92kEchFF6SHGgh3oDISOdkBIybglm1tMt
 ND8z1kL1Ygdpswvj7b70Zrjp4lUGhHKckWhgzhjEfZZqfRTOBAVc5LGCdm/JhCaV+oUP
 PyId123owe05nVVF4uLDFtyCXnOQmqf8HO0HspHQuXHGyAg7/uboZ8dguC/aGQrEGf1s
 5eKD4N/XzEb/g/hvHJI83PpNCts1VOBo5DJGCsJCipU9oDMpdgOqy8jKvO9TZepNsPof
 l+nMaDZmRbx0m9JA8UyrYpmukLM0BBSDtBPPcSpq9/8j+CL2NuciC7/D3HVXwTf1XeOk
 Fzig==
X-Gm-Message-State: AOJu0YyDbajYVH+BEWPmC/jviDoJiqNvZp/QkyZshBZRhk2OSeqdRr87
 Sgopb6nO+auzpL6pBTaGQiMmeCp8Hh6P/ULU142kaLlbrKdoH9p6e/MIPbPYSf3+4YtmknGdK+E
 JyeduY+35UUslYDcD5gDVPIph9rZOMWIhNIFR5H/on4m4TTbN
X-Gm-Gg: ASbGncuiIVbC/w/lTNWV1ScmUsoKloabiXt9pFQ6kPa9aTmWlyoxd+uTXTawcd9s3Ud
 Bq4WAvm2U1PeJnCmaD4h4fJkoICBa3Tv2d3hxA7p0XF1T+fwsR/yGyNXc3QCNVtz4yHKAEgKibT
 OcBQ1oIUUIUEdM+dVS9QsyFCb4fMI6emW/XrdWaVA8nFVCDgiM5WpNckWVAxPZ
X-Google-Smtp-Source: AGHT+IHBBs9yZgklJ0JokE9gnYsQJT6H44O2NLEylc7rPMoavEnEx+x6VUp/Y54XEZhJgZ9fpL/oIxHNo4lX013XRKE=
X-Received: by 2002:a05:690c:6d01:b0:6fd:4072:2c5b with SMTP id
 00721157ae682-6fda3030599mr73549607b3.24.1741210585568; Wed, 05 Mar 2025
 13:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-7-luca.vizzarro@arm.com>
In-Reply-To: <20250224132823.196509-7-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 5 Mar 2025 16:36:14 -0500
X-Gm-Features: AQ5f1JouSSPAyJjhAHEllm-RLA3b6HZ-SEJzlnZIsstvG7IPn1Tuz6mDLcXAp9o
Message-ID: <CABD7UXOHXS74Zo+ThksO=BR5-0GsXdsZhk2xGd5MjoV4-NVzAw@mail.gmail.com>
Subject: Re: [PATCH 6/6] dts: restore TG setup and teardown
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
