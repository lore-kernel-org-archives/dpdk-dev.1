Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B554C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 12:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1026240E0C;
	Tue,  4 Feb 2025 13:45:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D08D940265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 13:45:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738673122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJfL9SRr+Tu7mZIrKRUMhb6iqrPYXxG8M5rYaw5YqPQ=;
 b=EmQpu/zwE4GBo9gbLUeyET09Az694JENgJwpiZ6xc8ShbV9mqTGtQWRX/12Ekgmo+OnHD5
 iwqZq21WcYN6jShXKJE6gn5H6FqB3hNeH8mrKxR9dpwO8DUK7HBp6j/Jigc7Aa6EBmwIJ7
 PNshI9lmdj5eEXTox/PMGPEQEDmbQxc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-PlU2ABBDMrS1EL1YPVXYDg-1; Tue, 04 Feb 2025 07:45:20 -0500
X-MC-Unique: PlU2ABBDMrS1EL1YPVXYDg-1
X-Mimecast-MFC-AGG-ID: PlU2ABBDMrS1EL1YPVXYDg
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30226a472caso32663021fa.0
 for <dev@dpdk.org>; Tue, 04 Feb 2025 04:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673119; x=1739277919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJfL9SRr+Tu7mZIrKRUMhb6iqrPYXxG8M5rYaw5YqPQ=;
 b=WJrP383ARFvGu8m8GHRcC7n7DSvbb2Z2woNTiQstnD91xkhry5XSekqkPbdp3OjYE6
 vTFAVeF/xYm6K5E/mimLxRLSbVAWlteIXd0fZAZp0FjGSohCiTURdxAL1JbV1dJ2/Dh7
 eAZZsiorx/VZUGOH7Jpan2VXjsBu078wbA9y50IRNx1/iHUh1yeQ4VKY2wRvvP22Yjy5
 do5F6OjKL6CbVSfEphro5LNcMJoEjNXCdWGMoCuQe1UNArEh5QTDrrtAA41WxcpQQPah
 LCBeHtebknHvwpcQ8+IfODtixwUulCfED4zNLttePEap45PVU5yN7tchXTQyyYYvlpK+
 laug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZae6QNw1gwGv/OyT+r9x4bKpN8gI6I+aJBKb6cmIZWhsiB++bYSEXfoYt/rk4NbeH1CI=@dpdk.org
X-Gm-Message-State: AOJu0Yx4tq/s/nEaqy6bQiayeEKjbF1QJGDUc/JLC/aBh59ThDr4J1Ag
 PFkNINKO1BWhaXS78atA5YBpyiWfvhCguE28+70WQLzmH3AAc6Bo8qBJZeu+Ch4aCCUUjWyzOda
 gZdr8ibVJuBbCNF/tMAOfi/4g3AZk5MNpIaJyVN+aSjVWKcHKBkcNBhA/s5deEmaa2m4n8o/Z6u
 Hb7bx/HHx9pO/VtnI=
X-Gm-Gg: ASbGncv5xNeFE0youWfcRC8j0NFYk+rUQEdVjUZ63DPjS89lSdVaHA7pk6GOOnNFLwO
 ey/ctkjZv88SamuriIVgcOYf9zGdq7V15wPdV11b46+acwOETFl0kakUg1kIIPMul
X-Received: by 2002:a05:651c:2121:b0:302:1fce:3938 with SMTP id
 38308e7fff4ca-307968d42c1mr90535921fa.11.1738673119201; 
 Tue, 04 Feb 2025 04:45:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEve8aRLHdO66xIC6a7pqmMhJX4kSaXJSZTu0wRCX6+pu4TXG7XIsyqBAkA3p9+n/mca7KOSSBuauAgoIWYjDw=
X-Received: by 2002:a05:651c:2121:b0:302:1fce:3938 with SMTP id
 38308e7fff4ca-307968d42c1mr90535761fa.11.1738673118796; Tue, 04 Feb 2025
 04:45:18 -0800 (PST)
MIME-Version: 1.0
References: <1738632218-5796-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738632218-5796-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Feb 2025 13:45:07 +0100
X-Gm-Features: AWEUYZnH4wMAdQUK9iS_r8aS4A9Y26bnNtmvG1gnlWjLOomvwpS72Y-QSg_lCKI
Message-ID: <CAJFAV8xbW89Yn0UiDBOiPdn4oE10Aiup7nbPvVMr+pzAKCe9fg@mail.gmail.com>
Subject: Re: [PATCH] stack: occasional crash due to uninitialized variable
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Olivier Matz <olivier.matz@6wind.com>, 
 Gage Eads <gage.eads@intel.com>, dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VrPM9ajB2EQlxeCmZR3xOzcY2teN3YoSAo09dCFSTmQ_1738673119
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

On Tue, Feb 4, 2025 at 2:24=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Variable "success" was not being initialized and there was a code
> path where the last do/while loop in __rte_stack_lf_pop_elems
> looked at the value of this variable before it was set to any.
>
> Compiling with msvc resulted in stack_lf_autotest sometimes crashing.
>
> The fix is to initialize the variable. This same fix was applied to
> stack\rte_stack_lf_generic.h in the past but was missed here.
>
> Fixes: 7e6e609939a8 ("stack: add C11 atomic implementation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Indeed, good catch.
Reviewed-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

