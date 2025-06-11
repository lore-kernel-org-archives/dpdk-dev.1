Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED89FC71131
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 16:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F213402EA;
	Wed, 11 Jun 2025 18:15:54 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id D0CF2402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 18:15:52 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4a442a3a2bfso834661cf.1
 for <dev@dpdk.org>; Wed, 11 Jun 2025 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749658552;
 x=1750263352; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZtIIhyFNXK0KzC9yeo0nwXWZjhdoluCoRSmJ4qgvD4=;
 b=w0HYKbWw1jy/OBPbja5q4c2cCPlQ2Ft9A+aaNJC3ZtXGa8TAKSGhICTpPLqXX9ZJyd
 tAfmQV924abpdpkNzGmOhG92LcWHGisjky13JWhxFMw7o90YPojkc88jA1MZ+0NtFTss
 gnD+RL2Yq2WlyvrGwGZRlQhTYG5mmltVKh17ohOxfUCykuBiK+V8BrBceQjI+njpUrOs
 znqioKo/WROz8GILfWuaQKqrT0LYuQiMtXpAKZfT9R1KkaDzsyXY1wAiH6bPA1gFcmWt
 6MCgchcMCj8S3C6sAZPU9nchWyxrDRr+bgsQYL95xqrARYdLHUELtmXMsgerW5n+rHk9
 qlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749658552; x=1750263352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZtIIhyFNXK0KzC9yeo0nwXWZjhdoluCoRSmJ4qgvD4=;
 b=EswROQg1y5irTSOakzOVyIIBpy8SMoHYxl2h46GTng3nrltyZISEjETVqABpDLNoGx
 TGcktRHIwfuV2Q+kpQ/1CzFveVyeJgmAv6jssARltNWhrd8j8mgptqRX7J2B/x2Ow3a0
 QX7VL004pkofA2h/yc69+dUZLiICANyZFL3g8hPpBB/a2ph9YVrVprcIRUL9ZRnpLmbM
 i8kp2B3BYO6YSIt3naUDQp7OZlR1fa+9do2x1m0pGsDh/u3NnvhwaBLTkjy6zAL/L0TB
 v7dLru2CXQxunavWtiAN2l3J62QEFuQNyuLqIYodRv/PK0P7EIrAJHGOYh56f/wmGD9+
 IYsA==
X-Gm-Message-State: AOJu0YzDhGKUkLbm8JhpLzXqfFbYfOuH4E9IfKdT6VYYTQ9jN320QhIJ
 j/AIMnZXmbb6BbVwB5+OyZ4BNcjlqeZz44nGlsQUxvpE+z25lFO/PPsYmChL1TEj06U=
X-Gm-Gg: ASbGncsTG20syjWEZQDep/+XdyVcJ9cbATTUrjL6H2nisb/pBgWfLvPBxW/JVwCjLB+
 oGtZ2T0xi/Jc8PgBeicKWvjSvGAg7WoW3UERlNxG8BwbOP18Q1j9iJ3vWjswg+jNqwH4uYglp7r
 zFjTiU0xv7estFlB8SypiIZ4zjryzGS+JhKCylqz6N1tn5j/X97iznTgFOSip3SbIy8bOcqYdVJ
 C6ZqHWHH/nFPzNm5/L46nIEaEF6HgqB/TFSCRKff3h5DHm1GS2ofH5oigSzERZP5fx+H6SB5+md
 nzUCmuvcjusEw9GHLqkQ4NIq7vTTvnZ55BF2Wu4nT7mOGhADtcRascL888UZ+aKQ9zvk2Ur8fsS
 GLuOyvsk0FFh/c4SdG6DpMxHBa6XcsKeMtbC9eEQ=
X-Google-Smtp-Source: AGHT+IEIrTHSwCVXlqwBiSnQf7u4dndSZaOVyJXUB2MovNzO42VElF9+PXAPY0WkYUtk/V2Igu2gHQ==
X-Received: by 2002:a05:622a:a10b:b0:4a3:398d:825c with SMTP id
 d75a77b69052e-4a7229dda5emr3661131cf.48.1749658551769; 
 Wed, 11 Jun 2025 09:15:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a6ef785c23sm74249701cf.35.2025.06.11.09.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 09:15:51 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:15:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v4 10/10] bus/dpaa: optimize qman enqueue check
Message-ID: <20250611091546.3d5e101a@hermes.local>
In-Reply-To: <20250611071039.2939950-11-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-11-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:39 +0530
vanshika.shukla@nxp.com wrote:

> From: Hemant Agrawal <hemant.agrawal@nxp.com>
> 
> This patch improves data access during qman enequeue ring check.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---

Recheck-request: longarch-unit-testing
