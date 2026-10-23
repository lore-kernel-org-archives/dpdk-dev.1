Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4F606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=DYmtHfLW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BA2840268;
	Fri, 23 Oct 2026 17:46:24 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 4B62C40265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:46:23 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3acc96a256dso634585a91.3
 for <dev@dpdk.org>; Fri, 23 Oct 2026 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792770382;
 x=1793375182; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BENHjr6bTq0QzcWxA/+Da+WM5Ej4jXqvhm5Nt7wrSKE=;
 b=DYmtHfLWCOkDOQ48DbIyr4N71varmZdK4cT19NR3jfQ4/JKA1jfhFB7crxl19ZSJc0
 3eiq81e4sbJjeFTBNRJoTSS6UTZ7cou522TP9tEkASKaNqLugrBHJ6PFXvU21bga1jRE
 8cWZQ3fFPucRdpeqEU7ssHjNA4gZrWIVmLI07oJYG3Lkx0i6aiZ+UdAX1gZwgiVpZpUA
 hu7bcp8vzk6JyhPi3cFU+2f3Vbib7y62GTYEZ2tHgrj9/9v0rrUpHB7B3SMqPba7A/PH
 he1ymVn/uThbao/joQcaeYmNmo71BJRLIRkBLlgxNcYiPrLdOsKnABh/eRo/ry+JGdpP
 SlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792770382; x=1793375182;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BENHjr6bTq0QzcWxA/+Da+WM5Ej4jXqvhm5Nt7wrSKE=;
 b=Uv1lWjDCGiEtA+IAct8MmlrUEqBlqKgXMoIAXKUCo3c+W+sw7s43jvNfcP4rSnDCve
 FZYAG8E4m7z7TfTrq8RB/M4wqWORUvGR556DkqvIourV2Fl5YtahCzjbQddN9/2vlLKs
 ADOpEKh5eDwAo2qiYmOFrENdMKnptlxxu0Ava3iY/M86hr9EYDzFRHqlGUu7J50E6kKb
 kch6XsdJuko8Hr+D8E3xLvI6jTzBrIHYzJQE2z8VwZ+YOqDXTLx9aDmXGgLu6YwcrRr6
 ljzavOhIYQtuDzrKkt6oFcJQWvH4Dz9n8z6mCOrPzXaSAaGnwguqHtuje2VTeoC3sgwb
 Iofw==
X-Gm-Message-State: AFq9FYLE3yJAe5ToF06fwhi1ZwWSZPjkm5uj2XYtEmpyroDwEno/k8+B
 Y9Annlw2aOWdJ2LMPhV61wXYkWK57UO1zBaWiuDToPW2CTZg/0/z1rhj3g98P+4FOm8CC+hTWu6
 r1/v4d9U=
X-Gm-Gg: AYBFou04xK3o3glTvEkH4OhwXezcDcvLANipoBhDbyQUHP3tfwKAjmLGNI5aUn4+GEO
 dcxbPQYUXMFxor7HbEL2IGUgQcC8Kjm99JnPgCR9dceWBAuh8WQUvvkFB0Jmt53lfa5cOHIXcNy
 7JIAq5UiviGAPqhaboGyYWrGXz88WX9OUrmdD4Dwapl/MGEINGkBoddtgyojMtE7fOdYvlMKhIj
 XaJD9Gx9aHFKGzKIzFyodzrikTVSYqQPLuCYN6/hqj5y33lPwYO1VSvXZ1u46Z6IN9inEiQhvEc
 1kXA3nmjfSKYaf6uUkXL8IRDalhaY2hxNxzN47AQmPqKzfMJvsrWmbolUqSd1we6if7X69Nertj
 C13xSfNm/Hr15i3PMYE4Wvu2u/rqmwy4Knmi7ibmAquZVEYETbm/IS6CWKyqUnGen0HQgckqHQ3
 HID8I1Z1ivVd6mHbOQiua+7uQAxoKH61oHJwqENGQ8bJJcNp5DrkLk0+uJTZigOfLhcPGgdVk/k
 VIWzN9lYbCo8jl+QjvPHLCbYAD54kdgOVmVu/f2OZbe4PYfw9hsFEBRTMnMbzzPrjQigABjd9Sa
 jCyiDs+UcTSlZVkMS0yJqw==
X-Received: by 2002:a17:90b:3dc5:b0:3ac:9176:e837 with SMTP id
 98e67ed59e1d1-3adce0cda5bmr2393075a91.50.1792770382066; 
 Fri, 23 Oct 2026 08:46:22 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3addeb56578sm585741a91.11.2026.10.23.08.46.21
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:46:21 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:46:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Unreachable code in examples.
Message-ID: <20261023084619.1da78551@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Building DPDK with clang and -Wunreachable-code shows a common pattern
across many examples. They all have a for(;;) loop but no exit condition
for the loop. 

There are two options here.
 - do real signal and cleanup (preferred)
 - remove the dead code.

I am busy but if someone wants to spend 1/2 day doing and testing
this great.

[3666/3960] Compiling C object examples/dpdk-pipeline.p/pipeline_main.c.o
../examples/pipeline/main.c:188:2: warning: code will never be executed [-Wunreachable-code]
  188 |         rte_eal_cleanup();
      |         ^~~~~~~~~~~~~~~
1 warning generated.
[3687/3960] Compiling C object examples/dpdk-mp_client.p/multi_process_client_server_mp_mp_client_client.c.o
../examples/multi_process/client_server_mp/mp_client/client.c:272:2: warning: code will never be executed [-Wunreachable-code]
  272 |         rte_eal_cleanup();
      |         ^~~~~~~~~~~~~~~
1 warning generated.
[3715/3960] Compiling C object examples/dpdk-timer.p/timer_main.c.o
../examples/timer/main.c:126:2: warning: code will never be executed [-Wunreachable-code]
  126 |         (void) lcore_mainloop(NULL);
      |         ^      ~~~~~~~~~~~~~~~~~~~~
1 warning generated.
[3735/3960] Compiling C object examples/dpdk-service_cores.p/service_cores_main.c.o
../examples/service_cores/main.c:226:2: warning: code will never be executed [-Wunreachable-code]
  226 |         rte_eal_cleanup();
      |         ^~~~~~~~~~~~~~~
1 warning generated.
[3763/3960] Compiling C object examples/dpdk-efd_node.p/server_node_efd_efd_node_node.c.o
../examples/server_node_efd/efd_node/node.c:394:2: warning: code will never be executed [-Wunreachable-code]
  394 |         rte_eal_cleanup();
      |         ^~~~~~~~~~~~~~~
1 warning generated.
[3788/3960] Compiling C object examples/dpdk-rxtx_callbacks.p/rxtx_callbacks_main.c.o
../examples/rxtx_callbacks/main.c:348:2: warning: code will never be executed [-Wunreachable-code]
  348 |         rte_eal_cleanup();
      |         ^~~~~~~~~~~~~~~
1 warning generated.
[3816/3960] Compiling C object examples/dpdk-skeleton.p/skeleton_basicfwd.c.o
../examples/skeleton/basicfwd.c:218:2: warning: code will never be executed [-Wunreachable-code]
  218 |         rte_eal_cleanup();
      |         ^~~~~~~~~~~~~~~
