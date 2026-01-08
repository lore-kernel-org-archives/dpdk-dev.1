Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6AFD1D482
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 16:30:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 385FF402D3;
	Thu,  8 Jan 2026 17:30:10 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 71A724027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 17:30:08 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so4820622a12.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767889808; x=1768494608; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G8CehXJs6TOI9TdOndPqffAcxA7BOWLpKChSt+qef4w=;
 b=YrR5ZxqpESjy+35x918DrjoUWjR2hfBOw404UTZiGOiAMTEtC6K2aFDADNcIrinOy9
 vB2sR6KAr+kx21EP7klQUgtx9mbt+w3Mfy6cg4asEIXO1IXA6QLyjgCMof4kmjjScmAY
 wK8Ms44TgnV//rXMASj14sk0Al0NlvFhWU8U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767889808; x=1768494608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8CehXJs6TOI9TdOndPqffAcxA7BOWLpKChSt+qef4w=;
 b=hjUraBiovVH+bqbIVE9bT6HIxopXK0FO+ROkVmZFvrwh4KtHXDCB8gnX+jPr2vrvjc
 ao0Hucxha0znb0fBWedlg2wYcaNYBB1YlQTgd4/RsBQP+M+M7zlyidCV6Joiw8j/JBbX
 mJQ4ZzbzncvFMHjo6Af+7HzUrtuJSTVSULWVrp7p0bGcsuPoPJQHWV7yipv2xk+adSYr
 J4iskoDKj/B7Ur2FYQ5kU2pyj9ggIlPOqKStY7lc5FeD7tn9jCNtZUwxLAlOCEl0CN4t
 Pwp1BOEsbuWBZHCDkTStRjeycqAjg01S65P7lgh0dUJ9jEiJ1wrq8/hhIG07/nPCWceI
 fd1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8O9jgHdn7c1hqGhY/4kJQINsGhdj4MwRN+jjXeCONHYqjHqk3MUY6bY+ckP3ID+e8wek=@dpdk.org
X-Gm-Message-State: AOJu0Yx2Wn7SrEAGXQba6vBR/OeqipdcfRyL4lH9Ixvp42+ONwms0t7n
 tOe7vUms4QSL6pUhYxUpC12RzLWVHcVDBJWPAg7a/R2zczZ6lRqYTzyPLytTLfIe4Th8Dm4f7OF
 sQ4CN6B7uJfUBEZyJZh78B6SMT4ZxpF+XwOK44kutHA==
X-Gm-Gg: AY/fxX7kTRmOX+KMWDSsI8E6PQLMl1lxm5jMLz0lH3YppqrXY4nvlYUzDHF1Mb1ZZCb
 U5z4IhMWNBvJsjC/I2967GdLfQ3MUshuAegIZSQoH/W2vumn5PmU6QaovKqWWd71g5LUaPKZDGt
 y6pUlp5La0xfMDqK3/Y40nBsKZdb6fJdxzBx5j28KzzgO6bBQjZHfmQKQyujIKGkxflNgPkbgxD
 GR6qJc8kHVmOx3CsJPsdfVescP/zZf2gsdnob/eEGEV4w2pYs5QE0Elp70VhRRvT7il92Hcd5VT
 gmKO95HCOSU=
X-Google-Smtp-Source: AGHT+IFQhKvey4wyLJZto0FlzFbz4hYOC98Oophtrk6EM2LGmW/ZStWIjGN6POEr2L9KICE/++NTlXOpANADGSD+79A=
X-Received: by 2002:a05:6402:27ca:b0:64b:4212:9d4d with SMTP id
 4fb4d7f45d1cf-65097e4d1ecmr5380314a12.21.1767889807918; Thu, 08 Jan 2026
 08:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20260105190647.63244-1-abailey@iol.unh.edu>
 <20260105190647.63244-3-abailey@iol.unh.edu>
 <CAJvnSUBTtGyQ7WtE9GF-gawS=A8rHAqcaqTSo8eWYa+GBkhRwg@mail.gmail.com>
In-Reply-To: <CAJvnSUBTtGyQ7WtE9GF-gawS=A8rHAqcaqTSo8eWYa+GBkhRwg@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 8 Jan 2026 11:29:55 -0500
X-Gm-Features: AQt7F2oNKjDBMtVffLYzs5f7uhQoZGkDTQ0lVeKzaHJ7H3x3-Dxg7ljk3hPruuE
Message-ID: <CABJ3N2W6QXQ1Aae4QWaZhSMrwMfmDa6oYjHby1YDQJdK2FknvA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000000d5920647e2ec86"
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

--00000000000000d5920647e2ec86
Content-Type: text/plain; charset="UTF-8"

>
>
> +            print(f"Skipping test: {e}")
>> +            raise
>> +        app.print_stats(results)
>> +        self._verify_throughput(results)
>> +
>> +    @func_test
>> +    def openssl_aead_aes_gcm_encrypt(self) -> None:
>> +        """Basic test to run on all NICs with openssl virtual device.
>>
>
> I don't know about the description above because the testing is being run
> on the vdev, not any NIC (which really isn't involved in the test).
>
> I see from DPDK docs that crypto_openssl vdev supports aead aes-gcm, but
> so do the physical devices, and you have a separate QAT case like the
> openssl one above (and maybe this is a good solution). Is the idea to have
> a testcase per device (physical or virtual) per algo?
> https://doc.dpdk.org/guides-25.11/cryptodevs/overview.html#supported-aead-algorithms
>

      The idea as of currently was to go through every run of the cryptodev
application that I saw in old DTS and make a test case per run of the app.
The openssl test case was for development and can be ignored, which I
failed to note in my submission. There are runs for virtual devices that I
plan to include within this testsuite by the end of it and each will have
its own test case.

>
>
>> +    @func_test
>
> +    def a_wrong_devtype(self) -> None:
>>
>
> Can you explain the name of this test and its purpose?
>

        The last 3 test cases can be ignored as I made them for debugging
purposes in development. I simply forgot to              remove them prior
to my submission.

>
>

--00000000000000d5920647e2ec86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">=
<div class=3D"gmail_quote"><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Skipping test: {e}&=
quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app.print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._verify_throughput(results)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def openssl_aead_aes_gcm_encrypt(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Basic test to run on all NIC=
s with openssl virtual device.<br></blockquote><div><br></div><div>I don&#3=
9;t know about the description above because the testing is being run on th=
e vdev, not any NIC (which really isn&#39;t involved in the test).</div><di=
v><br></div><div>I see from DPDK docs that crypto_openssl vdev supports aea=
d aes-gcm, but so do the physical devices, and you have a separate QAT case=
 like the openssl one above (and maybe this is a good solution). Is the ide=
a to have a testcase per device (physical or virtual) per algo?=C2=A0<a hre=
f=3D"https://doc.dpdk.org/guides-25.11/cryptodevs/overview.html#supported-a=
ead-algorithms" target=3D"_blank">https://doc.dpdk.org/guides-25.11/cryptod=
evs/overview.html#supported-aead-algorithms</a></div></div></div></div></bl=
ockquote><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 The idea as of currently =
was to go through every run of the cryptodev application that I saw in old =
DTS and make a test case per run of the app. The openssl test case was for =
development and can be ignored, which I failed to note in my submission. Th=
ere are runs for virtual devices that I plan to include within this testsui=
te by the end of it and each will have its own test case.</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">+=C2=A0 =C2=A0 @func_test</blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 def a_wrong_devtype(self) -&gt; None:<br></blockquote><div><=
br></div><div>Can you explain the=C2=A0name of this test and its purpose?</=
div></div></div></div></blockquote><div>=C2=A0</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 The last 3 test cases can be ignored as I made them for debuggin=
g purposes in development. I simply forgot to=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 remove them prior to my submission.</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div=
 class=3D"gmail_quote"><div>=C2=A0</div></div></div>
</div>
</blockquote></div></div>

--00000000000000d5920647e2ec86--
