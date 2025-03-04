Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02BC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 20:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF957402EB;
	Tue,  4 Mar 2025 21:33:55 +0100 (CET)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9E718402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 21:33:54 +0100 (CET)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-307325f2436so60535581fa.0
 for <dev@dpdk.org>; Tue, 04 Mar 2025 12:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741120434; x=1741725234; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=CIqCKxuBsFYbpDdfCiULYPbvtOR8H6o8WnyFxTWPGgc8Da0jLrdO4yqWMKdDlSdS0L
 sNfQZa3DBEK9DYjwkQxbtYDN5SDigAZMCEorsZbcY+CNPVsxTkYf5RU2aPZg9JytyB14
 HuNZcjyRhHXmjQIH1/P6Lj0Ndsw9IhTjuLc9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741120434; x=1741725234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=KRkeKyR06iYhi9mhSt9BJJWIYu5QJAvEnquEURklfKFkuWFGGTIXz9+W5BQO5FZ/AW
 7QV2biuWs8iRLMb3QhJ6SXoNGfrHrATrceg+em9M8Zh0vEjqj+/FLSe0npRb4CSyrJhP
 lkZszM3xBvodga5WX8m5aPOOz6X4z551ms9NH/hEFfJDzAIl3prWNkzNl6wpdEbQwut6
 AZCB5Ld9rzQCUxbUS0EZuU7ybr4TLosgsJixUiUgU/+5U9svwL8gx/xAROjY6jHzHo+x
 UBxNNbDMjiYNd8NdooyUA98v9iD/LEWojM7djsYmyuwmY648iLuyxxjYpLkcP2z5+mUG
 6OdQ==
X-Gm-Message-State: AOJu0YzEyhOoxj3uQcgfL8haLJT9r3jfgtuyXF+Teha6bc77ei5UufIT
 Q5Ku/6lnMtK5N+dMGeuKMneA2IlOEDrWZay6TWuAS0BJVDEQ6P1k0oM4gf5RqTDLYXDCzfOsqaP
 PPIkHyqcQMTTeLJtX2VA5R+k4zf16Lqe2Cc00bA==
X-Gm-Gg: ASbGncsu0Nrz8Sh8P1eoPSnOZ0pIvE6WATZKO394xZzQNKPeYuzSdO3OCWMIjvpHNEB
 6ottlk80kHPvokAIOngOAMVTv5IcYSRr/lJttQBp6usXQWyDz4pk9RAIP++Uir0jO1CKutrFhyt
 lBxoezcRXFYMlDqbtcTK6QGWgrWjFJg2J7LiH9wOvmRE2Hv563ykesMjbHFjoR
X-Google-Smtp-Source: AGHT+IETsYOiWoWEgIO/DVIX0Tn+o0DoR93lldLEtQH8VkFv/B3BJz0N8Tx7tJa2aJ8aWWJOfTkhOQab6Gbgjm/DQtw=
X-Received: by 2002:a05:651c:154b:b0:309:25f6:8dcb with SMTP id
 38308e7fff4ca-30bd7a1f949mr1885041fa.5.1741120433945; Tue, 04 Mar 2025
 12:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
 <20250303145709.126126-6-Luca.Vizzarro@arm.com>
In-Reply-To: <20250303145709.126126-6-Luca.Vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Mar 2025 15:33:40 -0500
X-Gm-Features: AQ5f1JovbRdK3Ncc5zin9Elmp2KhwCTqRqFOWRg9javO9LYttYKjEjssppWZ9ck
Message-ID: <CABD7UXPX=SLctkrEjS_1w3+COuv5UjF5mUiTjYcRFtubUX11mg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] dts: run only one test run per execution
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
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
