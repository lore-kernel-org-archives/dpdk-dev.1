Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C51C982DC
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B80234027C;
	Fri, 18 Sep 2026 12:29:00 +0200 (CEST)
Received: from mail-ej2-f15.google.com (mail-ej2-f15.google.com
 [74.125.228.143])
 by mails.dpdk.org (Postfix) with ESMTP id 507F840276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 12:28:59 +0200 (CEST)
Received: by mail-ej2-f15.google.com with SMTP id
 a640c23a62f3a-c254f9f7dbfso61568966b.2
 for <dev@dpdk.org>; Fri, 18 Sep 2026 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789727339; x=1790332139; darn=dpdk.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l3wXzEY3+07e500qCMiSaHnA0DxVUl7lTj6kM/raN8Q=;
 b=U60J5MHVy3DxNYEkpkRZv5WQpCanoDsV8a/riRurswj/DfECmtLS7xTXAATmKD/imd
 nLwQVhjUA9WHr6azXsWxuBorGQONFPhPJm6D7z2QW3x70oIwrejfiK8cn0S8xxv4pX7U
 JumvzrzBv4/NWNPWan7cKq8FU7IrG+vvTCJf9M60SMAx8Mtzc/w38DzxR/3J3NpFefAj
 y7wUG7uGC3ecWr4BLkK4C2iNq3zqZ9IbB4EDwuGDqWsLlapXq8+a5L5h8TsiGHkDdle9
 EFsgfSY3vY/rk16uoc0Gy+6qvZsENyFw+9vtQ3BGcIbpejgccRTJ2aI+fHJMkk+kP061
 gEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789727339; x=1790332139;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l3wXzEY3+07e500qCMiSaHnA0DxVUl7lTj6kM/raN8Q=;
 b=0Wssu9aI9wuVF01QFfiEEc7rjOaBdn3ufgIn/iPxkpOR08IwOUg/lT3Q4KkIi2ty8n
 Kn7dW/X5/u7hJzMJFXaQ2zitEPXRtaDjwUTiifbIucJoX3iPdS8I+ScmMNjGsgTKkq1g
 o9pK8tC/fj4vgwTN944ybfWBWjtadETfSlRrxgpm2f76RjdomoTaXpyx5QbYGeSVMoNx
 OUd6G5ZOe3r14uIyoxN6KmC7LVNilXApyB0c/raC1NiTnjUry/Js33sNO/tizbbub2dy
 gRBZ/k93QAlE36U0bX5i7r7QBrDyMsN4t+JOkL30mrnXe+iOTDA5oHeZRjoL8M4kyhOM
 0vMQ==
X-Gm-Message-State: AFuF++kjS1pp0zeie1fK7qGn/2dVSd8c8fHXLz+5/SPMrBopgD8IzNny
 GrXOKSpQxkwwBDbIgvkigiw+bnau9De0FjmaOnK4COIJqlx1iHGUF8tx20eAMt0cw9s=
X-Gm-Gg: AYBFou3s/mdkvVkwVcbnFkpBP0UH8d2T6/GMQHG4z/hS51101v3d5Jr8NMpBuZl4gIj
 5hh1pDmoMW+AiPXItezIziy8Pjig8bxsZx+B2rys+FEbbjrXdgDOfkGnWVmrkiZQVpk5nWJe5Xw
 +qzw0yS6JSuVt9HE/JQubAJMgPqUxlxHiMF6/lIkinfAmjUU8dLxHRdvfv6hV5hUtpvelE5nqtb
 ORox9U+ZMt07zKytYqQ3fCMdAwBOQ+PilhJZxq2LDrn80eoB4SnBMNb7IwGlpUGk25HZhDraRbZ
 n+IZWxvZUAqgMSD9oHZ6V2Epk5Gy/QD/5tnSVD+eBvrJPNWK6H1gTi0lRy/mA3M8rv1sIQUKQCE
 FxY1+mAmFS145RxZmQEqTNDF+QR9bf81mc6qsnZ2mcg3M11TJDw0yUl8WoJBvc0vsVddndjX/+2
 NaqTDooYLlk5JxSMUhcCLZzDi+WFHbX4kbs1dcqvCUz0/SFv0BrzrfCC+CH9+tS59fU5y1Pg==
X-Received: by 2002:a17:907:6d06:b0:c29:3a1b:ec8e with SMTP id
 a640c23a62f3a-c2a1569b034mr218783966b.3.1789727338690; 
 Fri, 18 Sep 2026 03:28:58 -0700 (PDT)
Received: from [192.168.103.32] ([89.101.57.120])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa5979cea5sm656666a12.31.2026.09.18.03.28.57
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 03:28:57 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------oqoyv1r0Lgp6aULYO8XBbOHS"
Message-ID: <78f3a2eb-a0d3-46e4-a4e7-113d3bdf6166@gmail.com>
Date: Fri, 18 Sep 2026 11:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] bpf: make bpf_def.h private
To: dev@dpdk.org
References: <20260917151916.48749-1-qm2k21@gmail.com>
 <20260918092117.74231-1-qm2k21@gmail.com>
 <20260918092117.74231-2-qm2k21@gmail.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260918092117.74231-2-qm2k21@gmail.com>
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

This is a multi-part message in MIME format.
--------------oqoyv1r0Lgp6aULYO8XBbOHS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

|Recheck-request: |iol-unit-arm64-testing

--------------oqoyv1r0Lgp6aULYO8XBbOHS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre><code>Recheck-request: </code>iol-unit-arm64-testing</pre>
  </body>
</html>

--------------oqoyv1r0Lgp6aULYO8XBbOHS--
