Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F5C9EC8D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 16:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 631EE40156;
	Mon, 12 Jan 2026 17:10:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB1EC40041
 for <dev@dpdk.org>; Mon, 12 Jan 2026 17:10:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768234249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukph/IyVum+b75MyaUlFu7Jt8HlLsT3ZH2jmGspGcHY=;
 b=cbXjrC6LYaJ0CK1h/rmyn9HOPDdPWyvIbhrMfOfngKxLQdGShLsWQevuzqb9EdVCjSjwTm
 nFCETDx5/hOhmTXMYzmnqIefLRjJ8HvppkKhE/jhUydBc3HgVrc4vh15OQ6lB2fa2/t0oU
 GckzstaXSUBkdb/53k65U1x+fGOx56o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-J9SvmwwhPw6XDbmK540s-A-1; Mon, 12 Jan 2026 11:10:47 -0500
X-MC-Unique: J9SvmwwhPw6XDbmK540s-A-1
X-Mimecast-MFC-AGG-ID: J9SvmwwhPw6XDbmK540s-A_1768234247
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f527f5easo2918111f8f.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 08:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768234246; x=1768839046;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ukph/IyVum+b75MyaUlFu7Jt8HlLsT3ZH2jmGspGcHY=;
 b=n1DkkN4Po3lywGrCNvoyn+VbFeiDmZaBWSyzInF2dF5zJFHqhOAlpuI+yALWjcU/yA
 rshnEjr0+ifm0N4NRd521PnOLU9kqOhyxFtk81UsQPypRRGKlw2F7j+6Kr9d1vWIMm20
 wdBmD7mW5OvI+6TrizdmTysT3LLpr0Fwew7wCckiBTEIY37QxaGIDcg/5SE/pM4rNMMD
 mFRVh1V0ZpbL7O9AePWs5Y8HZX1tEzSZHt9QZX952R6BvJIGMjVoBDyK5bES1wRhpt1D
 zCmgDYxJwAr1M56vGN+6Q2Wv9qxWznlD4YuAXNDP4nTyMybAAmdaZxLGlr9dNuFusc1O
 gIgQ==
X-Gm-Message-State: AOJu0Yyde6X6NSkv94vSoSJxZNvRx9Bz4EMlN+KXQ5jnjpIWs5XfSBQr
 wmhfBFiSQBR/HYTboAsq9lT9qQ1eQmtb0Qzek6yKukQQNwPzm0TQ2EpkNv2n00jc68a/iwrydIo
 XM7m1w9MKWbPg7vAhh8HWlxhHEfHoxSZBmzXc9JNsDd8g
X-Gm-Gg: AY/fxX5z85vTH/3VhvjQ6xeqUjPWuKO/Sb9zywFjjTtRH1DCF/wtnsH3++vT0Dq/AEK
 jGsWJ5SrDYV7JQMedBr20cir9vJ1KKjBQGQ/roFineHp53f//Tv4j3hfynyxGBCI9URQNxrUyTn
 bPCHTsf/jBzL7ObiQovmNuO2HF3OVmKx3iQX50PWR0mEM4CrwTJAUASQjNuXj7MCgep5Q4rDVW5
 MhlP0EbJ1Arl5nXByatfqXPrOz8C86enMHFVNAdPT5tlXR1udV/iZ9RYcxCQl1Utw5NgF8Ai0Ru
 D6htVY/V7DQ0UqcPUZa2VYYPGO4XVqw/kpD4/7mbhenQR4nvIYbCdIF/vyH6xco+qj+FYPdQkta
 hNVwt8tiVDf7bQ6bPwzsbQoL7EYWuoWzG2rJy9rSYIvFbYYhrjWNgl8sLmWNri4TAhhg=
X-Received: by 2002:a05:6000:24c8:b0:432:86e3:84ec with SMTP id
 ffacd0b85a97d-432c3763569mr21422242f8f.23.1768234246665; 
 Mon, 12 Jan 2026 08:10:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+P/fJGQdlubCQsCcvQb+hKNZC82/oonv0cb++iGdy2Fk2sGE1GPerIkSDsZF4XWSY2kc9LQ==
X-Received: by 2002:a05:6000:24c8:b0:432:86e3:84ec with SMTP id
 ffacd0b85a97d-432c3763569mr21422196f8f.23.1768234246252; 
 Mon, 12 Jan 2026 08:10:46 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm39814912f8f.8.2026.01.12.08.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 08:10:45 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 12 Jan 2026 17:10:45 +0100
Message-Id: <DFMQQ63UZ4JI.32CUBILUJ8TJU@redhat.com>
Subject: Re: [PATCH dpdk v2] telemetry: fix adding dicts in container arrays
Cc: <dev@dpdk.org>, "Bruce Richardson" <bruce.richardson@intel.com>,
 <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Matthew Labrecque" <mlabrecque@iol.unh.edu>
User-Agent: aerc/0.21.0-97-g6d065a9aaed3-dirty
References: <20260107215129.1329960-2-rjarry@redhat.com>
 <20260108105036.1341037-2-rjarry@redhat.com>
 <CANGnzyBfmEy3Vccqywvzota=R2CNv1h+cgvfiawq5+qJqA4Rsg@mail.gmail.com>
In-Reply-To: <CANGnzyBfmEy3Vccqywvzota=R2CNv1h+cgvfiawq5+qJqA4Rsg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pgEDNhmcc_Um0_IjGNMu5LCBgYJfxOj3er23UVOKkiQ_1768234247
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Matthew Labrecque, Jan 12, 2026 at 16:56:
> Hey Robin, my name is Mathew Labrecque and I work over at the UNH
> InterOperability Laboratory on the Open-Source Team.
>
> I wanted to email you regarding the ARM cross-compile tests that failed o=
n
> the patch. While it says the tests were run on Ubuntu 20.04, these tests
> were actually performed on Ubuntu 24.04. This was due to an internal erro=
r
> where we hadn't properly updated the labels for the tests.

Hi Matthew,

OK, thanks for the heads up. I don't think this error is relevant
anyway.

