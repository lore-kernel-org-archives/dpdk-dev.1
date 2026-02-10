Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246BFEB2705
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:38:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FC374065D;
	Tue, 10 Feb 2026 20:38:46 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id D7CBF402B0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:38:44 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-65a35fc8007so563144a12.1
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:38:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770752324; cv=none;
 d=google.com; s=arc-20240605;
 b=RK5wsDpkh/7u3ikcTXOBodYiZqpCP5h0u3xuoHOx4tuST43MJAg7Xk4Yxo0EHYEu00
 AW6N9dLIo/L0KsbkW5nFXZy38Puh+CK9DLkxQjqTuHncoSU2w2brX9oUHd8lk+cXY/3C
 ii2fgZMt9L39oUYQneqjWmIeyt9tncBjil78LAoO1MhhC27UGpVKXoZ3tCOobXC5EVrC
 YbkJKL1NcT9xMSa56OrEVB1TOOt9qcdliAoAsd8BUY5jwmicnjU4DVNQ84S6CFRgky/T
 ZVkke7j7rb9WvLtpkxHhiRG2MAL3fpl0FjqZOpR70HClUDdG9NudJlBAh+RYqdoUS4Dn
 Eq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nia0D9/IG0uDCjlYr6+SZ9daJonhFbGc3op3G3geuCQ=;
 fh=xo7y1RYUf3oonk9ADGZ6O9YTyZtsRyOIhhTeKc2tmYk=;
 b=f5rJf8veXTKCi8K6qd1fQOnv01/3FTYDTQaEnFQotWQhK02a98AUvbNFJpX/wCuUWY
 MCaxSRENo7aB+AuKL8UicYEP62jM58QjRPsAlyn37qpfvfgrTsHUp5kI25bxz1XBk65y
 tG6MweRklr3Zlv1MT3fVSkdaWDBrCoPzC+WprTW2julIWI1HF1azQthgJyo+DDmgWZYX
 zbbFLObdce8GqeR66q44h7ajTSn7eq8SSGOjH2hndpsTo9pvknvtPKXlcnB5TkOfHjyg
 JZDyi9n5/eztnhY2hZnlSXgMjMCmQprtkTieoixhAELNNAGnpdBRfqn4HjhNLxbQAFuc
 A+wA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770752324; x=1771357124; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nia0D9/IG0uDCjlYr6+SZ9daJonhFbGc3op3G3geuCQ=;
 b=LoI5+G624W5mE63Zy2dVvpT4xdov8cokpiX6hIHj/QmNDNUWH/kJ0ST+QlYtcQdnK/
 kosg+/hcN2Ho1kj5vvT/HkAsaiSqvDpDx87INBwR+ftON5eCc1BHcvuUZCsfp9rc6dHf
 X8XmRo6br5DyjprStbSSF2PTYojkVaJZ3lM2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770752324; x=1771357124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nia0D9/IG0uDCjlYr6+SZ9daJonhFbGc3op3G3geuCQ=;
 b=o/2GSgHWvR0hP7zqSqQTtYWNHhaq/jgAbz107TQ156JwbJ/43iPPMZQOnIdqNvaNJA
 Joa9eRMlz36IE4n3mvYHD9kebVx05fxEIMQOi8vV8cxnha5mSMOc+gV9QhD2SIaxv2Ci
 ZvT+u1u3jxb3+Amlnt9rkxTrkTpzxZAqtMvACR9M7lLu9wWVAo5n8hKt/GJGlHNh4phx
 g7zFbskqsZ1/zYAM/bN7lOBMgqDXYm5F8oY5vYHc2Wp1cmpaBBdgDya51Pyhr5t0F7Un
 UTCKgPI1dxVyCTUPLqBW3Vitfd3ufF0ZxFseAZnN/RYEgyCwSxlbSDsUCurwxsoupWIf
 1JMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUgzWKcgj+EyvZJbJ+UWuj3YtuEwXiNir7tCALWz6hx6dMWNa36m/mzfnut+0MfOE6/EQ=@dpdk.org
X-Gm-Message-State: AOJu0YxMX8Jv5aQp1qdWEkiia2xJuZzwv2evypG5GgrBYRPpo36SpEPD
 j6fZ8wuIGN6AqGQ1qzIjnkropfymmYlvdnomyyWQz8cxjNxgWD4VNrvEQcg1cfwIxGrimJkeL/s
 h/3lnCzlp4velSCh/h731YYZB1JmCFjMWLNPTgIXgeQ==
X-Gm-Gg: AZuq6aI2Hsr3lb2GhKXAAUy8jqqqCWR/Thf6g0BbDCLxZvExi7Ga0Hh8azswo3lbhnL
 SJ0kXA6gG7DDZbEtQnnF2neE6UEC+f7SWztx6jPRRGiJUyEcB9fIIeBohEgj0fc1HLLiTcBZ064
 43WrWd0wVvb5fSrxak5+5g94mqyJQi58HM2dVPnR+FX6YSa1UR5ok08W+7ciMVxB5fn4Q3dedXk
 Hr9ctboLJdW9IKDyrqUHOWwNI03WBUEfnaoHTReMSYWnk4mNKtI8bn9ayjlL0ccOhqwtAiVUCZv
 qg3a0/lsskH7dArRhlbymcjfIfY94+DRnzkm/rnM
X-Received: by 2002:a05:6402:5192:b0:659:431c:d8ca with SMTP id
 4fb4d7f45d1cf-65984139bf4mr9921946a12.13.1770752324295; Tue, 10 Feb 2026
 11:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260210180645.65880-1-abailey@iol.unh.edu>
In-Reply-To: <20260210180645.65880-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 10 Feb 2026 14:38:31 -0500
X-Gm-Features: AZwV_QjkISkv2Ehrkjd0qOIYQGpDad4v3wWznBQiiOViSV1pe_U1gLyNnkl3li4
Message-ID: <CABJ3N2W47m-Rm6VpZoBn4MsOcBTvLnL17xWBKxr1m3OxOBrAfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] *** dts: add cryptodev testing support ***
To: luca.vizzarro@arm.com, probb@iol.unh.edu
Cc: dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000466bfd064a7d6760"
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

--000000000000466bfd064a7d6760
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this series. See the up-to-date cryptodev patch here
https://patchwork.dpdk.org/project/dpdk/list/?series=3D37325

On Tue, Feb 10, 2026 at 1:06=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> This patch series adds support to use the dpdk-test-crypto-perf
> application. This application utilizes crypto devices that must be
> listed in the format of a port under the `cryptodevs:` label. Along
> with this, the application does not utilize a traffic generator and
> therefore a new test suite decorator has been made to signify this.
> Crypto tests must be enabled in test_run.yaml as `crypto: true`.
> It is not supported to enable crypto testing along with functional
> or performance testing. Specific capabilities of a crypto device
> cannot be gathered at setup and therefore, non-relevant tests skip at
> runtime. Finally, the application must be run with virtual functions
> and the process of creating and binding them has been automated within
> this series.
>
> ---
> v2:
> * Updated example yaml files for test_run and tests_config.
> * Expanded test suite coverage.
> * Resolved git problems where patches were removing code added by the
>   previous commit.
> * Updated test suite to only run tests that are configured in the
>   tests_config yaml.
>
> Andrew Bailey (5):
>   dts: add find float method to text parser
>   dts: add cryptodev package to DTS
>   dts: add cryptodev throughput test suite
>   dts: add crypto test decorator
>   dts: automate VFIO-PCI modprobe in node setup
>
>  .../tests.TestSuite_cryptodev_throughput.rst  |   8 +
>  dts/api/cryptodev/__init__.py                 | 134 ++++
>  dts/api/cryptodev/config.py                   | 499 +++++++++++++
>  dts/api/cryptodev/types.py                    | 185 +++++
>  dts/configurations/test_run.example.yaml      |   1 +
>  dts/configurations/tests_config.example.yaml  |   5 +
>  dts/framework/config/node.py                  |   4 +
>  dts/framework/config/test_run.py              |   3 +
>  dts/framework/params/types.py                 |  65 ++
>  dts/framework/parser.py                       |  28 +
>  dts/framework/remote_session/dpdk_shell.py    |   5 +-
>  dts/framework/test_run.py                     |   5 +
>  dts/framework/test_suite.py                   |   6 +
>  dts/framework/testbed_model/linux_session.py  |  84 +++
>  dts/framework/testbed_model/node.py           |  10 +
>  dts/framework/testbed_model/os_session.py     |  34 +
>  dts/framework/testbed_model/topology.py       |  92 ++-
>  dts/tests/TestSuite_cryptodev_throughput.py   | 691 ++++++++++++++++++
>  18 files changed, 1856 insertions(+), 3 deletions(-)
>  create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
>  create mode 100644 dts/api/cryptodev/__init__.py
>  create mode 100644 dts/api/cryptodev/config.py
>  create mode 100644 dts/api/cryptodev/types.py
>  create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py
>
> --
> 2.50.1
>
>

--000000000000466bfd064a7d6760
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please ignore this series. See the up-to-date cryptodev pa=
tch here<br><a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D37325">https://patchwork.dpdk.org/project/dpdk/list/?series=3D37325</a>=
=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Feb 10, 2026 at 1:06=E2=80=AFPM Andre=
w Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This=
 patch series adds support to use the dpdk-test-crypto-perf<br>
application. This application utilizes crypto devices that must be<br>
listed in the format of a port under the `cryptodevs:` label. Along<br>
with this, the application does not utilize a traffic generator and<br>
therefore a new test suite decorator has been made to signify this.<br>
Crypto tests must be enabled in test_run.yaml as `crypto: true`.<br>
It is not supported to enable crypto testing along with functional<br>
or performance testing. Specific capabilities of a crypto device<br>
cannot be gathered at setup and therefore, non-relevant tests skip at<br>
runtime. Finally, the application must be run with virtual functions<br>
and the process of creating and binding them has been automated within<br>
this series.<br>
<br>
---<br>
v2:<br>
* Updated example yaml files for test_run and tests_config.<br>
* Expanded test suite coverage.<br>
* Resolved git problems where patches were removing code added by the<br>
=C2=A0 previous commit.<br>
* Updated test suite to only run tests that are configured in the<br>
=C2=A0 tests_config yaml.<br>
<br>
Andrew Bailey (5):<br>
=C2=A0 dts: add find float method to text parser<br>
=C2=A0 dts: add cryptodev package to DTS<br>
=C2=A0 dts: add cryptodev throughput test suite<br>
=C2=A0 dts: add crypto test decorator<br>
=C2=A0 dts: automate VFIO-PCI modprobe in node setup<br>
<br>
=C2=A0.../tests.TestSuite_cryptodev_throughput.rst=C2=A0 |=C2=A0 =C2=A08 +<=
br>
=C2=A0dts/api/cryptodev/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 134 ++++<br>
=C2=A0dts/api/cryptodev/config.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 499 +++++++++++++<br>
=C2=A0dts/api/cryptodev/types.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 185 +++++<br>
=C2=A0dts/configurations/test_run.example.yaml=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
=C2=A0dts/configurations/tests_config.example.yaml=C2=A0 |=C2=A0 =C2=A05 +<=
br>
=C2=A0dts/framework/config/node.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A0dts/framework/config/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0dts/framework/params/types.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 65 ++<br>
=C2=A0dts/framework/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 28 +<br>
=C2=A0dts/framework/remote_session/dpdk_shell.py=C2=A0 =C2=A0 |=C2=A0 =C2=
=A05 +-<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
=C2=A0dts/framework/test_suite.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +<br>
=C2=A0dts/framework/testbed_model/linux_session.py=C2=A0 |=C2=A0 84 +++<br>
=C2=A0dts/framework/testbed_model/node.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 10 +<br>
=C2=A0dts/framework/testbed_model/os_session.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
34 +<br>
=C2=A0dts/framework/testbed_model/topology.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 92 ++-<br>
=C2=A0dts/tests/TestSuite_cryptodev_throughput.py=C2=A0 =C2=A0| 691 +++++++=
+++++++++++<br>
=C2=A018 files changed, 1856 insertions(+), 3 deletions(-)<br>
=C2=A0create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_throughput.r=
st<br>
=C2=A0create mode 100644 dts/api/cryptodev/__init__.py<br>
=C2=A0create mode 100644 dts/api/cryptodev/config.py<br>
=C2=A0create mode 100644 dts/api/cryptodev/types.py<br>
=C2=A0create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py<br>
<br>
--<br>
2.50.1<br>
<br>
</blockquote></div>

--000000000000466bfd064a7d6760--
