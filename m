Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F6CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 18:55:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 089D3402EE;
	Wed, 24 Jun 2026 20:55:20 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id DE45A402C6
 for <dev@dpdk.org>; Wed, 24 Jun 2026 20:55:18 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-697cd68d7adso2278967a12.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 11:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782327318; cv=none;
 d=google.com; s=arc-20240605;
 b=jrsPdnjbjB7+6tEeZ9CZLsdoDbHBWdWaPowSbyII8MezGPuf61RCaYnoKRFzbEnH6z
 cwj7ZaNjE5MgAk0dlSADPkAD2hhLebs1RnUAQpDrH6TteU48clfDZX7TwBM4s6zvhOBQ
 M1/q39XH0WI/jy5TutqQx70vAKieTGgLsnIMPPH87Xf/Db1Vrl8mSZVhXLb1HYnPiLHr
 gNoKEH9B7de4fsseIG7cE0EsblTZfV5qYf6aL/fR3yM/3ljVtEYFLO9yVos1MzCU+z0D
 mI7v+eFgUjAIPdL0NWafYpzQ29F1c0PEUBeLJPHzvPafuCTy672CDe4m5FYtjt8LDP/F
 QqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V70aCoJc3c8P4w6KMiiMlhlOIaX5TCJ93ZYJRuWf3O0=;
 fh=49+zhspVG4qmnlh3jW2EPeV4g9E41/c1u6/NW0pueUQ=;
 b=Aar1BYPGHfhtOnkAc6rKSxAXCwQd9NQV7rvsFHxcTufS+WvvpqASfK3fWIrlGwnsfu
 Yx6C80i9UK0DK3klIQlkNghv6/znuoVgF8Ag0l0DbKTA8E7GOEpIFwU20+YUIrlc6Rjv
 nlI1RYY9yzhg4HjaqjrWdgLVePu3pTz2MCwY9ezcFFSngCzS+sdPe2Jq57j/MGn0UzrL
 2KfltF8ZqpB0TDDN//WfRt5jjQ1Jt9Q6UHE7EVhuea/Z2I9FOc8ciG17l68uxPOnLRWb
 jY72pjsIbNXYUtQ0d1TgtK7cfnnHDRE7Ko+nlnXndVSEjwe/hGT8QEoaAkVg74p4Cqf1
 jvTA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782327318; x=1782932118; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V70aCoJc3c8P4w6KMiiMlhlOIaX5TCJ93ZYJRuWf3O0=;
 b=du6MCaHic3q2sabWb7N7Dd1uEaQxe4Kzv5NRZia7z04IEYg9SnSZyQNRl3MBbypYV+
 1jN+do1U1OuWVNsqGfB0nQcOCH4dNtMhExJqfXEx3tFpTQzR70not7oVaFkAWbCjenPY
 iwej/OYcTer2hQS952NdmN2sTtj8KAn+rl4k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782327318; x=1782932118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V70aCoJc3c8P4w6KMiiMlhlOIaX5TCJ93ZYJRuWf3O0=;
 b=P8rSRDKPZmMb+0vzvJ2UCSRMUDhAROpirJbIExQNcIa+yEfNI45oMbQhPbXit1Djyo
 o7onm5/Y0jepA9ZyI8p2CdLfC3ptD6+TsB3bduxRQPO7Izly6vDoE8P7xwV0EcjT+IT/
 EPMjLQJx+RTYq6O0FWvEmvy1xTS5b/12ws59cMww4TDtrtf5ji/Rzw3waWT0bnxTD3bW
 SCY14ojgS66xh23xLnBp61YYGiWJl1HMWteq3qxX/jQTfqZ4vjdml5ByBlxTeVcDnsgD
 5JCJy+ytsiR03tDx2Bf9aRXq0FhUJ94t0LQIaNF5gIHF4yaEP/uZP+u3QT1tOfCcH0vd
 MlGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqz05un0zU8O9VIm7ML+lPjbS+11+UwKyBxIybfsyPNIaOu211MbRqgQs9ClIDRSlMFEB4=@dpdk.org
X-Gm-Message-State: AOJu0YzmDgi5NnmUTaXUA63IBGTJ1pLcJQLt3FqAb/59uA9DLBxbVzeJ
 3zwyzh249KoNNHCzobMegCs2jaYp7kjlW0KXQesyrYlLOnMNVcAHl9QG4uw8M3YiXm85mgGu3UJ
 NS6KCZeeQ+HvlCQV9Y1k/6Lu1u7HRuDvXYiPd1NLSBQ==
X-Gm-Gg: AfdE7ck+Qvfd3NRMF4SdFU8hUX3G6hmL0weSssvZiFFZg2ySvLR6ATzoMNENn22wQrT
 rgK2kHftuVHJ1ZXzxCRKwk92BVb6RiYPVYj9t9vIlwoJYey7O6fBHZXgNk/A2qmJZPdrveOvNsX
 8gEaBxQajGNv0oVBkXsg9+oj9Xw7V0HoDmVKA4Tb4K8aerz71H/731HL36JHncswfKe4S3j5yzJ
 Uwcf/xJIN3kVS75eqj9o93hAAHdkqEF4AOpf9uUxHLA2nnrfsXI+lsRO6wVaxLoAgRoB87ISD62
 PxX/+HMvNgLcNct0WMNaBWSLmnDaWyY=
X-Received: by 2002:a05:6402:26d2:b0:697:d3bb:de6c with SMTP id
 4fb4d7f45d1cf-697dba78bd1mr4590756a12.6.1782327317574; Wed, 24 Jun 2026
 11:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260622170223.1152746-1-knimoji@iol.unh.edu>
In-Reply-To: <20260622170223.1152746-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Wed, 24 Jun 2026 14:55:06 -0400
X-Gm-Features: AVVi8CfCJ0itk2JwY-T4YRbY0uFJrQxoChzh_m7XsWZuaOMZ7L7MAnXoBBkgIYE
Message-ID: <CABJ3N2VvUjaex6RVJpYc0cbraA5H8ZpsAXMwcZkY23SLfDjGhw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: add code coverage reporting to DTS
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000a34b380655046a85"
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

--000000000000a34b380655046a85
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000a34b380655046a85
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div>

--000000000000a34b380655046a85--
