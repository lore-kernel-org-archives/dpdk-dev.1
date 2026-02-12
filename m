Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0EEB48E8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 08:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC6A24027A;
	Thu, 12 Feb 2026 09:56:41 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id B651F40268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 09:56:40 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-65a431e305eso2433782a12.0
 for <dev@dpdk.org>; Thu, 12 Feb 2026 00:56:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770886600; cv=none;
 d=google.com; s=arc-20240605;
 b=feazJWsbwB1FjXgO9//kH1dTsnZB96kzoxd5d+eTVggMNMbsWDP0nQSaBjEIjCH4ho
 f1obpwatpStqVT6yZqKndvnDivcv3lKlwjwF8eL+p3QBV2N64ZfCpB58PIEQuDQGRerl
 siODFmkHeFD+miOPjGVpcWvxnGN8lw1rJGb4KHTty7TFeRiN2DbLKD+9knGIDb63ZXYQ
 Huw/omWd4JbkjjMPzJu9YtVDAtX/1YwdXou/mExmnbS/cf7vn+06ofzcLHa5TGPv8pPG
 5OsopnNyT0xXf6YHwdyWNUjh+di92gSBqOTT5l9J8XUwQwJZorCPfs/ZnJiTNQpcPnhl
 EBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ROuOMO+A0tKIYFtNWBspDU4NduCKx5Z7nfB0OtLVFhs=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=TNusT1W6/oAVBzvZ4VUFVgZ5gJAM7aRAHDFMAfj9TzGF086+NMnUAIahkhmd9sOL3d
 9RoQGS8PMCTIOX0GYVgalbAuGNvpY/2qjlj6nO1xHWSDyiQnlC6s+wx3tVPqp0BY5IUC
 D9z7m9Nx9IOPbcJNpuc+6+2SXowEulkxjZQdG2rz8FpKlEvLGuCOVnimJTYkCqkwtjwa
 bV22w7UmvxMHroA3VF2/2Ufsz6eW4LSvh242LfGu9IvY1IlbVOV7fAhm+QXNwgKtLrEP
 DAhZot/gsyKxlRCGr87+qwdauqwuoqWtQisDWDRY8/LcHCXIAGTg7QLi7GPJGmC8wW5U
 i5tg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1770886600; x=1771491400; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ROuOMO+A0tKIYFtNWBspDU4NduCKx5Z7nfB0OtLVFhs=;
 b=uHE0lsufMutLOnIL9Hwh3jh5PjDkMxR4tlIFZ6FVkpphzL5+/Sh8SoNDSzo4j6oXYE
 6lkKvmlPoUck8IE8820hWxvpYtL4o+/8bxkck9pLr1ROxOex/1eQm6amyrJjKJIJnVr8
 61UC6GekXzmFqpJj8zAuBF60kn3Chs9s/oAiIFNJoHPyXs40lyNMzUSF6xWST+YfOhhv
 3srqERSEZu76PFd8vPlRT7f6lYrQ455ZT5pQK1uPDY/odhypQZ7T7rP/JckPnWbG6m8Q
 +RD9CLfFsCyz8brWcyuQflul3O6pkdnwQtnWs4NfsNY8Gi35+euFYHz7LOuFs7ELSnss
 1f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770886600; x=1771491400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROuOMO+A0tKIYFtNWBspDU4NduCKx5Z7nfB0OtLVFhs=;
 b=KwVyHjYtLmtBPECw/ed3xKfPBXl6kCj77Hu4L2ZDMHnhUguN6A7HUGVYHD2gI7r0XN
 tSGM5ActyuZiB1NQSne0h9o0QkELzZqNm6UDlR7ey3XiMvYaHgpcEaXwxjI1RjK/KTdS
 WFbqr93pOnNrlgl29Ne6BJGVnwG/0Rz5Yl/Wyub2FcSSsATvIyK3PsGBGoVbh1JgkOiq
 XO+dKGZAdetVDhTr67eM6ax73oO/uLeGQ5KY4qWALb9OrzqudHFanOPS76k+k7/I3kue
 U6qVDF6zVFhkjQoeIS4TA6bsFyjyDALEi7YPob4Eb0UAHf4zmegShRqzdaEHNkjH+A/g
 JWkg==
X-Gm-Message-State: AOJu0Yx4xzEykmNXHz4Q5GF3kHW3q/BlaHZVqn0Qo04/tgJdiwGl8OiW
 iXPWE5sVktUF75XHRIje3F2OZiMF9z1/yrqjo4FwjmrW3VHPH3etp3wiKiiuD/PWLD5gK84C9q8
 AglxUx5Yk7PzPa/2fMDM8rWPuaQ0WNvCbO7OoCKg/c/mP3vmoXC/BU+xBQQ==
X-Gm-Gg: AZuq6aJNXtB+8Bbsc8jfHmPDucgfWXx42hE6DGyXBs1UnfmuEJSb1EfP1Eou+Z6GczW
 CDXA5rUpGl4EyiyfrHPWThDX+uhO6Hktzm3yFYiODGxRyqALaxpsiShWNdAwuARe22HZ1qdIHmN
 73iCcKSr/F5Vu9V9HqEpaPT5gfuS/eVr/6K/TNkp0PwrBUtjx/yDTD8IQvwAMK8yEk5NFIsUJiM
 SQdHZaBfb0gadlYirGV0ohARhQHSga0AE4VuXh+Ks1g9Ma4BN9G1Gcs0yDNg5b59Nsw16dRvggI
 vnNFcFg=
X-Received: by 2002:a05:6402:398e:b0:659:3fca:24d0 with SMTP id
 4fb4d7f45d1cf-65b96e046d1mr863858a12.29.1770886600194; Thu, 12 Feb 2026
 00:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <20260210064506.5e0475f6@phoenix.local>
In-Reply-To: <20260210064506.5e0475f6@phoenix.local>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Thu, 12 Feb 2026 09:56:28 +0100
X-Gm-Features: AZwV_Qi3mBvVhKv9EMuxKOaUfna-6l3nSZcoAkPzIHLlsmRATxGqdWQ6FvdactY
Message-ID: <CAPQRu6G7tYzUKrOYDhpWZ6hQSgRbGey0cE4Qj8zyE4BXREOGrA@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] flow_parser: add shared parser library
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000be0d33064a9caab8"
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

--000000000000be0d33064a9caab8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 10. 2. 2026 v 15:45 odes=C3=ADlatel Stephen Hemminger <
stephen@networkplumber.org> napsal:

> On Mon,  2 Feb 2026 12:36:52 +0100
> Lukas Sismis <sismis@dyna-nic.com> wrote:
>
> > This series extracts the testpmd flow CLI parser into a reusable librar=
y,
> > enabling external applications to parse rte_flow rules using testpmd
> syntax.
> >
> > Motivation
> > ----------
> > External applications like Suricata IDS [1] need to express hardware
> filtering
> > rules in a consistent, human-readable format. Rather than inventing
> custom
> > syntax, reusing testpmd's well-tested flow grammar provides immediate
> > compatibility with existing documentation and user knowledge.
> >
> > Note: This library provides only one way to create rte_flow structures.
> > Applications can also construct rte_flow_attr, rte_flow_item[], and
> > rte_flow_action[] directly in C code.
> >
> > Design
> > ------
> > The library (librte_flow_parser) exposes the following APIs:
> > - rte_flow_parser_parse_attr_str(): Parse attributes only
> > - rte_flow_parser_parse_pattern_str(): Parse patterns only
> > - rte_flow_parser_parse_actions_str(): Parse actions only
> >
> > Testpmd is updated to use the library, ensuring a single
> > maintained parser implementation.
> >
> > Testing and Demo
> > -------
> > - Functional tests in dpdk-test
> > - Example application: examples/flow_parsing
>
> I am working on being able to use null PMD to exercise rte_flow.
> Will add another automated test to exercise flow parser in automated test=
.
>

Great, thank you (also for the little fixes).
I tried to implement it in Suricata directly, and it suits me, so
hopefully, it will work for you!

--000000000000be0d33064a9caab8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">=C3=BAt 10. 2. 2026 v=C2=A015:45 odes=C3=
=ADlatel Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org=
">stephen@networkplumber.org</a>&gt; napsal:</div><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Mon,=C2=A0 2 Feb 2026 12:36:52 +0100<br>
Lukas Sismis &lt;<a href=3D"mailto:sismis@dyna-nic.com" target=3D"_blank">s=
ismis@dyna-nic.com</a>&gt; wrote:<br>
<br>
&gt; This series extracts the testpmd flow CLI parser into a reusable libra=
ry,<br>
&gt; enabling external applications to parse rte_flow rules using testpmd s=
yntax.<br>
&gt; <br>
&gt; Motivation<br>
&gt; ----------<br>
&gt; External applications like Suricata IDS [1] need to express hardware f=
iltering<br>
&gt; rules in a consistent, human-readable format. Rather than inventing cu=
stom<br>
&gt; syntax, reusing testpmd&#39;s well-tested flow grammar provides immedi=
ate<br>
&gt; compatibility with existing documentation and user knowledge.<br>
&gt; <br>
&gt; Note: This library provides only one way to create rte_flow structures=
.<br>
&gt; Applications can also construct rte_flow_attr, rte_flow_item[], and<br=
>
&gt; rte_flow_action[] directly in C code.<br>
&gt; <br>
&gt; Design<br>
&gt; ------<br>
&gt; The library (librte_flow_parser) exposes the following APIs:<br>
&gt; - rte_flow_parser_parse_attr_str(): Parse attributes only<br>
&gt; - rte_flow_parser_parse_pattern_str(): Parse patterns only<br>
&gt; - rte_flow_parser_parse_actions_str(): Parse actions only<br>
&gt; <br>
&gt; Testpmd is updated to use the library, ensuring a single<br>
&gt; maintained parser implementation.<br>
&gt; <br>
&gt; Testing and Demo<br>
&gt; -------<br>
&gt; - Functional tests in dpdk-test<br>
&gt; - Example application: examples/flow_parsing<br>
<br>
I am working on being able to use null PMD to exercise rte_flow.<br>
Will add another automated test to exercise flow parser in automated test.<=
br></blockquote><div><br></div><div>Great, thank you (also for the little f=
ixes).</div><div>I tried to implement it in Suricata directly, and it suits=
 me, so hopefully, it will work for you!</div></div></div>

--000000000000be0d33064a9caab8--
