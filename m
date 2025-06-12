Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090DC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 07:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 143C34066F;
	Thu, 12 Jun 2025 09:00:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B24684021F
 for <dev@dpdk.org>; Thu, 12 Jun 2025 09:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749711639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ODCnlJ+nuRBlU99P4frV6kcRl4HxhlO1PMjoBLAulc=;
 b=ELcJl5ABn6JtNCYbR/aPBR+eeLYSY7o3XomSSRhiGNhJAnhBCUR+rIWpTNGBqzTQsbbTmv
 X/q8Uas39T6Ht++XEV1NU8iFtVmu02Rflut6TU+HA7yRP/A/dnLvuxBS6k2RHpwgSs60B1
 yyRSwYrcKnDl6bAUVdvcKo6NgckSXiA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-Ifi_Xfk7MlKwLaBML7Gz0w-1; Thu, 12 Jun 2025 03:00:37 -0400
X-MC-Unique: Ifi_Xfk7MlKwLaBML7Gz0w-1
X-Mimecast-MFC-AGG-ID: Ifi_Xfk7MlKwLaBML7Gz0w_1749711636
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5536608f515so298766e87.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 00:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749711636; x=1750316436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ODCnlJ+nuRBlU99P4frV6kcRl4HxhlO1PMjoBLAulc=;
 b=JV9rUaeDfrT0sDpV0Vrs2IDxnRBSirg5VzTgDoY6P3z/jkLYCQ7g5cK4tb4wGeQ8U3
 Wf8pa/FD9U3sZzHBJZQIlDtju8MY5rP7GNFHBRSkxz4Z3qYh8CIYQwJsJH5GY9qsliBk
 ApbN140ZWJJZfWDU3OC2J3jLVcds4qoo0o2Mhve2UYi4mXG7X8nKOakqSsnkeJNx47Lw
 gG90R7cWs1uqVQm5OnYq+IMQq/1PuU0T/2SkoL3L/Pa4YNlkebysk0auqH4fpy27PtHt
 gxVV2PMYFy9+85JAKtcyCayBDciXcuXbes48tpnLmBa/9COUXymCiZludx76429Db+hE
 ilSA==
X-Gm-Message-State: AOJu0YzxYgrjnx81SVO17QCF6HeKwOBfuyZDAH2klvZ1dpoC9fHWKqEH
 Y8kqsK2iSgcN+hiHhw57cHgVVM4Nl9/qlMAxF1h2kHzkTeoiEFuGLL74NI0QBnvhm7HDh8Jz+P1
 ngPOPc5ZAlBHe73fLJVxmIynWyqNJyEpKWG7d2L3No1lIZfeSGNBo5zpuEhsi3DJBQ6EcbV8kAb
 PMaehLv0/kakpW+Ras/YB/rGGFFH7QbA==
X-Gm-Gg: ASbGncsg/+kmuSvPfsn+XwXlgwvoXSnCTUNKPkQNiVdZHqiRyvJNF5haqgNwX3QpFhb
 KJj8t+kKRk/8JaJllrBhfGzzBqfiSLjiTbbTmY4dweffiiJBOA5HCFvEHTxk769slUPTAl9JtP4
 6FFirt2w==
X-Received: by 2002:a05:6512:ad0:b0:553:663c:584e with SMTP id
 2adb3069b0e04-5539c268fd3mr1853735e87.47.1749711635811; 
 Thu, 12 Jun 2025 00:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvpbehOZGpshYrJiUHZsnhdbMnY0cBUwm/iToOsGORtxWqrrvwJuKKkX1QCLdoI62KOvwgF7HwjA7TOwCpUEQ=
X-Received: by 2002:a05:6512:ad0:b0:553:663c:584e with SMTP id
 2adb3069b0e04-5539c268fd3mr1853729e87.47.1749711635355; Thu, 12 Jun 2025
 00:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
 <20250610141355.91759-8-stephen@networkplumber.org>
In-Reply-To: <20250610141355.91759-8-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 12 Jun 2025 09:00:22 +0200
X-Gm-Features: AX0GCFvLRk75Myoydc-l9nQJI9-2Bvkm1l43YGjGzsI2PMMcT_oa90Qtih_xf7o
Message-ID: <CAJFAV8y1TqpS6_oN-j9n_PY8mHqCD05n8YU3Jq5VwfXwJUd=dA@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] test: update to latencystats tests
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4MG2xD3FrvpOWfBMYA6XbcbAUnG6pRsL9FK05wIaHK4_1749711636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 10, 2025 at 4:14=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> No need for loop and memset() here. Just use structure
> initialization.  Remove unnecessary initializations.
>
> Look at the number of samples, min, max and average
> numbers to make sure they look correct.
> Forward for longer to make sure multiple samples are taken.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

We have random failures on aarch64 in OBS.
https://bugs.dpdk.org/show_bug.cgi?id=3D1723

It may be related to this change, does it make the test more
susceptible to timing issues?


--=20
David Marchand

