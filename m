Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71932C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 13:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D9CB402EA;
	Thu,  9 Jul 2026 15:47:47 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 5F5EA402D1
 for <dev@dpdk.org>; Thu,  9 Jul 2026 15:47:46 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8f0e5e36912so13021876d6.2
 for <dev@dpdk.org>; Thu, 09 Jul 2026 06:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783604866; cv=none;
 d=google.com; s=arc-20260327;
 b=S6TBWAdCsFPZkeNgtT+CyVZluspXF5CDXMEy4OXmznGahC59fO976kNK1/GFzFlNvN
 NQQdS+92VplqJndkBpK3/Dm+XXSUqiml8ivRj3jO7jbwp1ivRkoTKso8XTOdQlwdkI+g
 U9Ex2hin7Qjxn1+Vdh9+32JKFV6f0xcVfkkJI2mr7kGczNzV3tjFuzBksYXBee7H2TeB
 plI9pa0ReOgUbhA1FEjXcsiliZgPeEgo/JfWzmSf8g5ctZMK7pHJpyQfEo9zuG+CbByj
 zjg+qI7zEnEX+Sy8VCIwp0cyagCeEZVPxjYOdUrFkcPXEMmt9hYmN5y78rDLxvIogP05
 j7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ze6WPjc9w8NS+il8QznB6FDvoeG8a6dUFbc2OWUgjGs=;
 fh=sfa82nnF4vfGs5+MVdQQl8NzH/NSE5azc4tcV2b3H1E=;
 b=bMCls9jupnWW0LUXfnwnOgTQsxz6nuqzFCMP07bOIeMi6KiZI69auhkXlMr2lkXNhp
 J41K91Ol3APFwTDzHynnrYOA3HWvYMiLWXK9gonIwSBYs1wYWRb+HUZjbojer2yRCVi0
 UAN2W97ThXnIJeK7ey8EpWg0/pedz8mTpCToeJuBtOPbW4dCpur2GTIxm7g2kFj04XFQ
 1vSxDZVzXaOA1i9j/XGKDp/2bpqs13+a5jl+iU6cdVas0zj4pIHPk3aRa1PAq9vLLhZ+
 2HC6hVrzqWR++HNh1wgtLAKM5fwRPGD5mRpI3hCm6HgD44ivduNFP03cX7dBVO9RPugY
 HoBQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783604866; x=1784209666; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ze6WPjc9w8NS+il8QznB6FDvoeG8a6dUFbc2OWUgjGs=;
 b=QbaINSEBJtVQX2TLhDOf2o05EjiJvVEpulWYg0EMdZFFUlbKN1Yo3UwNq/GkjEJAQV
 yGC1/q650z1qJDrdY3U5jdhepfdbwvvpUJL0ymyN9x2AE7tkwqGB4MRvgMMlYZWABDCy
 FBWQfJ54f5rd2FZQVjDSW//bw82h/wg8SVKyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783604866; x=1784209666;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ze6WPjc9w8NS+il8QznB6FDvoeG8a6dUFbc2OWUgjGs=;
 b=aETHRJEHzFF3opuqjDu/HX+67ooMJQ6epDcuQvZvaSppHPNYyXWYNo8fruIZH1zvIG
 OFpspbnGdECDWkq1Kiw8UgfAEIQnZgSDqmpM3c14oC5RNdiaNcXl4FpoaYG8B//gCphW
 QfPtqwClnhZnGhG1mboag2xFypTqJ1dBEqEezAati2q+rzg2fj0k5HZYH/+z/kxR1sbZ
 gYXBkKRiTx4tYjegVxeoDY1EhHt5Reuxip5Q6XC6K1SLDEO/HPhLARRHfmfYs0b7HEE/
 G887RmkGBjoPVEcp1Qa39TRT9+XgwhNbzpDk8XOSvxAxgludHGDDSkSl00qX+95OMIrg
 JLuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RribqC2pbzI1uUSCXIS7ZVdceCaFhGg3CoMqDOd2cEMscdG0FU1nwa8oAOON1qgjpv95Q8=@dpdk.org
X-Gm-Message-State: AOJu0YzrITnyvzUhdwlc10hB12GxW8+hoXUMnqc5KTOSVc90NBJSRsQN
 wDBencW7JExWNXzBdfpevo92WAsHNCkshPgCykiO1SzD/bAfrNciq/cht6cR+7Pq1TlvKazBkRB
 /W7y11ysJWo/GnQd9AoTGVtwVSvBPQ7tCVtalDkkuoQ==
X-Gm-Gg: AfdE7cky3lmVIpTKOyMw/C3Wt5cOQNDzJR+BR8u/l5crvKHoFMtCALAvtVl7GB6mQVm
 VrGFkP2hHfZqALqOUZ3PZdAinjxDgwr0VRY6CPKzmFk8kHkl4FIb/l0X7u0Tj2INpgCHqBlQXQH
 cX9N8YPXC3mXgRaCuoOW48S/ZnO05xGAIebPpb4jCVUbEDJTNFmEvP+EhQFgUfTjTZzDx8LoMMS
 8LC1cD4W8xqKbq6JD640uUoyPZnKF8ossCWtfBMrTa8kfvsFX2j8pXfTWygSCicBAd+cG8NEWBm
 ZJmXRqEZWoPLTgE1HR7wHAeUOBiIX/IBfJW+Yay02LYUXQ+kvYs6vVdnb/UrulK3qKzG6ywdlmU
 b99AhTOr3K9yBr4PiBYyGcoK1kWoA/lCCpnnY/0N08j90r8ajE2cpqZvj2h0Pt7Wu7T8vzU86
X-Received: by 2002:a05:622a:1312:b0:51c:7b13:62f9 with SMTP id
 d75a77b69052e-51c8b439112mr78733741cf.79.1783604865690; Thu, 09 Jul 2026
 06:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
 <20260625154712.2255474-1-knimoji@iol.unh.edu>
 <CAK6DuxvEjRGOQJMY-Amd+QUxQBAV9ihp35fX1PQ2D5p7bt=L8w@mail.gmail.com>
 <CAK6DuxskqPSX-wgxHLOmhd7U=HSYg2js99E7th76LeAY4CBbHA@mail.gmail.com>
 <CAK6DuxthwOFOdvLgsEoxu+ShXaiKZWc9+RuVXG9czsazuipzTw@mail.gmail.com>
In-Reply-To: <CAK6DuxthwOFOdvLgsEoxu+ShXaiKZWc9+RuVXG9czsazuipzTw@mail.gmail.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 9 Jul 2026 09:47:10 -0400
X-Gm-Features: AVVi8CeVq7Y9NCffnLyW9QgenE1m7HjzP3j8QoFVEqog8PVXR_vxeWtxl_uS8Lw
Message-ID: <CAKYPG+x8vt4-JSsNmAV2NSrjAQGPdKnOqWi3hMNp+ZkJCC+URQ@mail.gmail.com>
Subject: Re: [PATCH v5] dts: report dut/NIC info during DTS run
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000070875f06562ddefc"
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

--00000000000070875f06562ddefc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 9:05=E2=80=AFPM Patrick Robb <patrickrobb1997@gmail.=
com>
wrote:

> Actually, please see the AI code review of this patch. Specifically, this
> comment looks correct to me. What are your thoughts?
>
> **File:** `dts/framework/testbed_model/linux_session.py`, line 228
>
> The code checks `lshw_result.return_code !=3D 0 and lshw_result.stdout =
=3D=3D
> ""` but the logic is incorrect. If the command fails, you should raise an
> error. The `and` should likely be `or`:
>

This is definitely a valid issue, I will send out a patch fixing this
shortly.


>
> Please read through the other suggestions too. There is some fluff but
> also some good advice.
>

For sure, I will include changes from those suggestions in the subsequent
patch as well.

--00000000000070875f06562ddefc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, =
2026 at 9:05=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@=
gmail.com">patrickrobb1997@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Actually, please see t=
he AI code review of this patch. Specifically, this comment looks correct t=
o me. What are your thoughts?<div><br>**File:** `dts/framework/testbed_mode=
l/linux_session.py`, line 228<br><br>The code checks `lshw_result.return_co=
de !=3D 0 and lshw_result.stdout =3D=3D &quot;&quot;` but the logic is inco=
rrect. If the command fails, you should raise an error. The `and` should li=
kely be `or`:</div></div></blockquote><div><br></div><div>This is definitel=
y a valid issue, I will send out a patch fixing this shortly.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div><br></div><div>Please read through the other suggestions too. There i=
s some fluff but also some good advice.</div></div></blockquote><div><br></=
div><div>For sure, I will include changes from those suggestions in the sub=
sequent patch as well.</div></div></div>

--00000000000070875f06562ddefc--
