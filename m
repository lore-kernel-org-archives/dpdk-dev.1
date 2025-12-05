Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB806D2F7EB
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 12:37:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D98374027D;
	Fri,  5 Dec 2025 13:37:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C44AC40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 13:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764938241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vwMJkWBtVrj47Y+yHS7GqLYZoIz7ok1gct1cKzEzmNU=;
 b=emmWlRmE0VpF0ma7E27YrPfrjM60WkLznaOrc6shwLQDOTfQdw7nTJK5Qo9XdSS0VWuhIY
 7esgb77XI550i4vcrdkuvYueYYEJgIZb1M5gAaPkjScqj1k3ErqxsDNcO/tDR58fu7Ttqn
 1XnL5976edVsltbDzm+pBmX4CCv86R4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-2qlWbTqaOkqr0_ntlbx11w-1; Fri, 05 Dec 2025 07:37:20 -0500
X-MC-Unique: 2qlWbTqaOkqr0_ntlbx11w-1
X-Mimecast-MFC-AGG-ID: 2qlWbTqaOkqr0_ntlbx11w_1764938239
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5957bd7530aso2127377e87.2
 for <dev@dpdk.org>; Fri, 05 Dec 2025 04:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764938238; x=1765543038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwMJkWBtVrj47Y+yHS7GqLYZoIz7ok1gct1cKzEzmNU=;
 b=b3RUIXF9O1KZd0Z6CZo5YxYf6e1E3xIcR2v9mOlhaxJkeV02y5jZfQSiFXG5aKuoMt
 KVZgSpQeqSD/bkNF/eTci8XTNZuZ5Z1+DcgiMwxQXqBCyhq8W92bOPt9vKE9Lvnm1Pmx
 QEx/cEupKveqhDDxwylXCkhPxLGJaY9Zo3Xyq3SWtzb+D13iKg9e1DAA5O7iI29QIvRS
 2BCuqkziWWWBorNcGDz6+NpxZFHEvfdTFCTIQAaqosNF0zfhnr/pSsNSfMR3f4QKTQgI
 L/lN4vkXktUbQUD5WxJ230RfP/AlJE3rvwWmCJoc5KF9L7fJOKHovDXEj8HQ3LWE+Nro
 I13w==
X-Gm-Message-State: AOJu0YzOLc6TGCKuTSwPvlRBQ6pEZEGkqrgWO17p8i5E6rPhJ2SkisnI
 c8ABk22j+3KxD/6fP1DoCsQrV4hJ0+PS5O7IOnds2ciWQn6T7SOJx4Yd7aEUkqAdnTG69YjkAst
 jjNJnNkRmb1VywwDFdPQzMHDTT039pG+a2my02v9teAupOqWqvJeTTb6u226em0kS5dE/UDqZzy
 cVGgcXIEVCT5hh8a2muS8=
X-Gm-Gg: ASbGncuf4zIo2NH12+/y/usQ1Ncbr+quVe09FqZ7lgF+8RCdQwufY95wtkeF/ItH+kO
 JCoiDv9J6D8fF680LzGwAL0KryMJ1zP9H75UrrOu6/lG+OphmdATFBErMGuIwPlAMxdB/CgeZM5
 Ebs6O/meoLBbYuUYL3nQ5+wpKP93z0QHbwTOS1oGwuTGysGMU8P08J9tHL7npdxlefMqZZ
X-Received: by 2002:a05:6512:3e0e:b0:594:281c:c8cf with SMTP id
 2adb3069b0e04-597d66c829emr2284112e87.31.1764938238466; 
 Fri, 05 Dec 2025 04:37:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEorpLVQptqm1dy9mj798KxnmId5skbuqShQyQk8TtNLFcaNEXGwXDCrfrYA+0MXRziygZweX3Y9aOvalqnSJU=
X-Received: by 2002:a05:6512:3e0e:b0:594:281c:c8cf with SMTP id
 2adb3069b0e04-597d66c829emr2284108e87.31.1764938238022; Fri, 05 Dec 2025
 04:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-9-bruce.richardson@intel.com>
In-Reply-To: <20251204182047.3154429-9-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 5 Dec 2025 13:37:06 +0100
X-Gm-Features: AWmQ_bmxQvbrCxxArubX_38MC3363Td6ecV-5kvuQsCYSfNNwNtCo0dg3Q5F3g4
Message-ID: <CAJFAV8yatWvS8OhOJM1yXw1T-RBerjE2psNH0um5KG88T6jnYg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] app/test: add some unattached tests to fast-test
 suite
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uFqM9g9_6n67_sp-GRd0No8A7Uw2JkXDjiLJ-03lkDQ_1764938239
X-Mimecast-Originator: redhat.com
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

On Thu, 4 Dec 2025 at 19:22, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/app/test/test_red.c b/app/test/test_red.c
> index 7f38ed1469..4b17173999 100644
> --- a/app/test/test_red.c
> +++ b/app/test/test_red.c
> @@ -1872,6 +1872,6 @@ test_red_all(void)
>
>  #endif /* !RTE_EXEC_ENV_WINDOWS */
>
> -REGISTER_TEST_COMMAND(red_autotest, test_red);
> +REGISTER_FAST_TEST(red_autotest, NOHUGE_OK, ASAN_OK, test_red);
>  REGISTER_PERF_TEST(red_perf, test_red_perf);
>  REGISTER_PERF_TEST(red_all, test_red_all);

The commit 50823f30f0c8 ("test: build using per-file dependencies")
removed some context on why some tests were not part of a testsuite.
-# Tests known to have issues or which don't belong in other tests lists.
-extra_test_names = [
-        'alarm_autotest', # ee00af60170b ("test: remove strict timing
requirements some tests")
-        'red_autotest', # https://bugs.dpdk.org/show_bug.cgi?id=826
-]

I would prefer we don't put an unreliable test in fast-tests.


-- 
David Marchand

