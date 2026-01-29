Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EAFD3569F
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 05:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43A484026F;
	Thu, 29 Jan 2026 06:14:51 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 34EB14026A
 for <dev@dpdk.org>; Thu, 29 Jan 2026 06:14:50 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12336c0a8b6so1090092c88.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 21:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769663689; cv=none;
 d=google.com; s=arc-20240605;
 b=L9lTGXO8KkMbtE0Y7tRmPnF/4MpXhIHZ7A80wpoFdoTIqptVq/XY1fbzE0aglZj5LE
 OBk31ou3yfMswB+zjio+IU3Dt6lhHKog2yt6wNpsqRgNFY3flmiZal+qOFus/eKX4E3a
 jhjKyDbU3KqkmCCbxH7pfsaN5VrjynHJnD7YhlwzzzLz36aZpEtZq1wsk+PXWur5Ai5j
 NSpRTAkqOZHefBz1jXjwqFugA6DTsdFKRIc/57GZ94IyWeaC7ReAZzl4ttEcDqC78Y/b
 njJNoFBHYofiwwDvsBiI7AbIHgX2YUR/TQ4+mE7x7i6pU0e3QY6F3Yd+MSxOFj+8sfoT
 CT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jwAwZ6lu1MQyCvZEduNY0uJR9U5UsTf1w17VawYQTUs=;
 fh=tSDuEK0Hl3mMbUqfCkj7QIiqSbCm2mm5FwGJmNATtm0=;
 b=Yyheb4bhPGcDEQXXOIsoOKyOswiGVievJn3mm/hvXUjA9iaI90paTCD93+nbfgtTPN
 UJ0fTjEb9UV6FP7vfKrterzjrOxwW0741XbfYYTdFZg+qIs+sZpRbMNr78XB+8A3+jst
 +b0guYTjiIyARGw70w9xsEHHuAFF6IKtakdmYNVMOWeU/EoJOPMg81o4FqLz8wOaEY4j
 6dcFnLKDcn6zbQBt1PvAEOn5aiasH2miatgeg0jnlZd+ZRODEhwtIphp+FAknodJr7jm
 LjDJVMI067Jjv65Un5pY6UZvXhntRCjToVGExW1EFTT/0ToGs1ZyBq2EhdMYkvdp+MVz
 CZ9g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769663689; x=1770268489; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwAwZ6lu1MQyCvZEduNY0uJR9U5UsTf1w17VawYQTUs=;
 b=jBejKnZX78Z7CqRlkzWDyMThHawwVMrQsoUDjaAxC4fYh6kfDbZjhXxheUokV4zIP7
 h/ytZptYCUOj533HYUPalZeGQP6poOLM/mIZOyvQwDuzRYlE1DUZUnXNdg5hpot/M3Qw
 DmQU2ZdwXR/TmSFMzEWL6to9zu9wWUPKCBzGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769663689; x=1770268489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jwAwZ6lu1MQyCvZEduNY0uJR9U5UsTf1w17VawYQTUs=;
 b=rViri2FWMaE7bjJHGkaTwC+hEAvw2uYtl6+6B7nDXO5mkFE9fYyHdRvjR+7gqdIdBz
 ffcok0kkphPX2JTNWXgf6GbTTPR0awBJoVIBAQwVL9J+IAf+2WZ3BIRk+GWbjgAqOScZ
 CMHNYk4eiKR+9IOKBU825EiKR+aao/J9Swvgyla1ITuuBpyVS4cB7Ou743BENPOzx0Si
 LW7glwhniAN3RF3SlPgeZMJCFb/l9BjJHHoLU8GuO7T3kip2Qbq4YzFEgHZkeKJNNjJv
 SSuJlca+n7gchzxMdUgk2MLoMoMTc90izxK4oznVH+74wdhtrpap20qhUxXKEFgO2e2S
 jWGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwP9J36tMsWRm47WEW8ZGauPhOerUCWX0VoRM93iNWfdRFuL9jFiEogZpXOUFcGc8uNtU=@dpdk.org
X-Gm-Message-State: AOJu0YzEdIRdETPjio4jPmfaeJX/kiK9gaXC7TTxjilPZ2ISZ8OfU/pg
 gDEx2KZpoSVBK/0czHG2DM4dYkyTzsJGBo26s/1/owBgyIeWmxcmxOkR7d37rgrQaelLX2Ymaqm
 FrsFmWo2cjHxAFlNoA/aXRuv7XwgioHpEGWqD9I4s0w==
X-Gm-Gg: AZuq6aJfhYN3iGpQgxxzAtORiZbX0Mh0WCCZ62or754Nw/lWCfc/Eg1rHLapsK/nJLU
 Bvjwatbsoshdk2JfdvlYHz1q9qd6a2O5tXGEnvk3hTJXyCi+HdUfRpBFV9rzAzaPS/8g+QZwr3R
 r//HDgaoXP7h5uPSWctdA6qToa50NJlmunk68MYmPEZupUmi6qRriDQMrxYoGrAg+EqHpY9Wrsh
 oyvzqynyWGQdK2+iTgbrrpS3cuKjIG5Cjee6v177GTVaqesCft+TAkh25LclhWMVFXzSgmqieKu
 XFrSvXJpQIH5h+P3VM46+edq3hwCTEJ7UjeWtqBcLYI=
X-Received: by 2002:a05:7022:24a5:b0:123:331d:bdbb with SMTP id
 a92af1059eb24-124a007e3bcmr4612490c88.22.1769663688987; Wed, 28 Jan 2026
 21:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20251217184637.719487-1-abailey@iol.unh.edu>
In-Reply-To: <20251217184637.719487-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 29 Jan 2026 00:12:24 -0500
X-Gm-Features: AZwV_QhPs9AEMJVf9mSAfd8XcQJO5VuQenjfcAQSemyeknsVVaohtwXuqAAbXvc
Message-ID: <CAJvnSUAgO5qGKX=e1EJ6-0G-EVtr2M_GjDU79yAP-mOTXnRUZw@mail.gmail.com>
Subject: Re: [PATCH v1] doc: add missing rst file
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, thomas.wilks@arm.com, 
 dev@dpdk.org
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

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Applied to next-dts with a reword to add quotation marks to the
"Fixes" line, thanks.

I noticed the QinQ testsuite is also missing an rst file - do you mind
sending a fix for that too? Thanks Andrew.

On Wed, Dec 17, 2025 at 1:46=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> The RSS test suite was added to DTS without an RST file. This patch adds
> the missing RST file to the doc directory.
>
> Bugzilla ID: 1850
> Fixes: 367e950f6d24 (dts: add RSS test suite)
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_pmd_rss.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_pmd_rss.rst
>
> diff --git a/doc/api/dts/tests.TestSuite_pmd_rss.rst b/doc/api/dts/tests.=
TestSuite_pmd_rss.rst
> new file mode 100644
> index 0000000000..942fa5ebdc
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_pmd_rss.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +pmd_rss Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_pmd_rss
> +   :members:
> +   :show-inheritance:
> --
> 2.50.1
>
