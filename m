Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84DDE6BF1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 15:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA601402AF;
	Fri, 30 Jan 2026 16:50:05 +0100 (CET)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 1214940274
 for <dev@dpdk.org>; Fri, 30 Jan 2026 16:50:04 +0100 (CET)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-124877d78a6so2811533c88.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 07:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769788203; cv=none;
 d=google.com; s=arc-20240605;
 b=d17+mVVuAHH9rY29CAPHn6kv8kDEpbVf07M8qUVcSVHDm604iCEzsFIfkLkJd+ENDs
 K7DOLvzHqRPi+O5vqPA0o8sP0yszfl6m5aU+JhzwGgacRHNtVtMQejOTyb5GvvTQ7iK8
 QxXvS+iyg8739jAPhnXIuTHo0IcirmNXyWnuqpHGe5u+dBTTzTmA7s8oQVaV2Uu+LlOS
 k7RBMQIZef+fKmbRVZGIAG9HwmB0MAYKfTXah4UpNi3DzGt64Rldb0Lrupl5bjBnYDA1
 jrJVC/AX78siS6GIq1/z74wQtSWETBmb+HawbHPmjMPG5aQmRKccExNayBF4JkKaE9ME
 e56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3CW7ofRf5SK94iNb1i4N5MXB38N2ZXT4XqNUxq2uP9Q=;
 fh=2W0PFbjewz8ZnRJ40XN4dirXyVKEkha224G7MuvK+S4=;
 b=TK1h+piiLb8aV4Nmhfh8HAs4smPh2siakww3zSjZzdmNDYSg4KpaatNnlheufhjbaJ
 d5/crYOa3rP/Wx7Q3tV9rPlmvFpMxiUJPy1H/jYQrexRhnFoCH9Dq+RlxRz+510oZTOG
 PVi6SYGzO4jcoeHnGI4RSqZJprzJrlrskCUKOdJdAbixy1L4sq/Pg7EEifPt7h9ttc5e
 wqgF9kQ4HXg+53Q/9+DMJp7o9nT/uE/WMZltu740LYcz6M2EKH9Nxchvpu77gfwHDzTN
 PjO5q8GbfaaxUaqDZB9BmkSatBbzBtnaOxtog76NccZcqpobsWWuSFrdEnqjjsJI/4ul
 FjCA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769788203; x=1770393003; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CW7ofRf5SK94iNb1i4N5MXB38N2ZXT4XqNUxq2uP9Q=;
 b=QWebENlqmEru12qb4X9z+O6XNnOBsey2iubNAMhdf50Oo2G/OB5/YPB4zXZrUp4i7q
 UsdtZDwdPiQql7qbYwAvWUs10cxlrkrryGEozTnP34MjgW+1GVZXfRahGpfm2gcX2CVq
 MG0C3N3dRvYKLqMpLJXUSL6BKpTLDBbLCSO/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769788203; x=1770393003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3CW7ofRf5SK94iNb1i4N5MXB38N2ZXT4XqNUxq2uP9Q=;
 b=hmm1T0VJNL8DrVew9r21x45a6Zz8V+pITtGj1jo6Qrgk5l090DsFbxAufW0vzfsT7y
 pHHfKc2pIn4rEAJYgpEeY1rlx6xCp8H/rHuXCy2FfijfOIou/5O5jqYqkfgdabJRWi8b
 B1kcNsN+xrou72GP/RD2VxrszD5WJfqwJ3PIFHuYtT9V1USWZtaUisKkc3AQDzSVPAAm
 cPZI9KczUbt6iLOSrvjSj54GLlsBxEXDXNfCv0dS4bBbiv6cwlqXYjqlKC+1bzvy5w9T
 sJ7zgcqn1ZoizUO8o5VKADfmcHQYlc5wM7jbW0um2GKJ45tiX5tPr9J8AmkdPc82WSvx
 IWZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTMfmpPJjmeZ1BPnVKK3JPJseeDEcOsDXoQ9xMeMAMSZrybsG8gNAjT6YVHcRNOGZMETk=@dpdk.org
X-Gm-Message-State: AOJu0YzDS3GhsmHD3qsPWOw6UX5JN5Jw4l9inehFz0r7fhFiaR4Ggw98
 su2mbANMdOp4FGrVtifDKsk8ry2HUCZNHmC0UQ+1/hWKi9r6mJPgkrvuDyd7KyQFlqHLrXxv47p
 M0B1uLp+Fr9BPUJ8l5RAmgweaB86JsKi2OM4o8PWSdw==
X-Gm-Gg: AZuq6aJMg0TTdE/PgA25x0D9k1syBAXT9Z51d147Ud5suz4ma04on/dnAopp0FZSRV8
 F6WB1jsYd8q+amaMaA4a0fMD8WN4rOdEC8pddaRRomptIZZGTJFibCTsqnbQscdar3ZgOfFPPlz
 AsteDHWMQGaT1o3RtS040jjKzjxq3MIE0B73IBXSSIOtPfKxBVnwiV4/JshiLdEIucrgjh/zPPj
 fT9PGRaRkhxvy76+oph1ZbMRjfmEEfGBwgVPAhDn3ZlmUKWVQQlTsry4PmmdFawRWwZlpnK/hw+
 fNh+cLpS7dE6puDp3DACDoK8/UFhB3UwkzrsIjm/hrb0DyfDLtzGrZud1aps
X-Received: by 2002:a05:7022:78a:b0:124:9acd:3bd0 with SMTP id
 a92af1059eb24-125c0f9a94bmr1851084c88.5.1769788202833; Fri, 30 Jan 2026
 07:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20260129191303.373877-1-abailey@iol.unh.edu>
In-Reply-To: <20260129191303.373877-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 30 Jan 2026 10:47:36 -0500
X-Gm-Features: AZwV_QgWhE-3ad9Nk3onSyyYft2bksbjHJTJYhzN0I5aMXsDxzCvsC0Gr4-06bk
Message-ID: <CAJvnSUD5+jB9y7oJvJGth5y3dMdnKDagPRCxUrrUmiqUFH0ikA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: add missing rst file for QinQ test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dmarx@iol.unh.edu, dev@dpdk.org, luca.vizzarro@arm.com
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

Thanks Andrew.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Applied to next-dts.

On Thu, Jan 29, 2026 at 2:13=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> The QinQ test suite was added to DTS without an RST file. This patch
> adds the missing RST file in the doc/api/dts directory. After adding
> the RST file, the docs failed to build due to indents in the test
> suite docstring. These indents were removed to resolve this issue.
>
> Bugzilla ID: 1874
> Fixes: 4f69c54bbb2b ("dts: add QinQ test suite")
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_qinq.rst | 8 ++++++++
>  dts/tests/TestSuite_qinq.py          | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>  create mode 100644 doc/api/dts/tests.TestSuite_qinq.rst
>
> diff --git a/doc/api/dts/tests.TestSuite_qinq.rst b/doc/api/dts/tests.Tes=
tSuite_qinq.rst
> new file mode 100644
> index 0000000000..827174fcad
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_qinq.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +qinq Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_qinq
> +   :members:
> +   :show-inheritance:
> \ No newline at end of file
> diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
> index bb385a0d91..505d71dbc8 100644
> --- a/dts/tests/TestSuite_qinq.py
> +++ b/dts/tests/TestSuite_qinq.py
> @@ -26,10 +26,11 @@ class TestQinq(TestSuite):
>      """QinQ test suite.
>
>      This suite consists of 2 test cases:
> +
>      1. QinQ Forwarding: Send a QinQ packet and verify the received packe=
t contains
> -        both QinQ/VLAN layers.
> +    both QinQ/VLAN layers.
>      2. QinQ Strip: Enable VLAN/QinQ stripping and verify sent packets ar=
e received with the
> -        expected VLAN/QinQ layers.
> +    expected VLAN/QinQ layers.
>      """
>
>      def _send_packet_and_verify(
> --
> 2.50.1
>
