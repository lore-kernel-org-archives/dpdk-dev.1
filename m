Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916A2C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 21:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E63F40268;
	Wed,  8 Jul 2026 23:23:24 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 4F49540265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 23:23:23 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so9220505e9.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 14:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783545803; cv=none;
 d=google.com; s=arc-20260327;
 b=Qen7YJ4iJ6gXuhsZHhjzq4rF52aOm1eOC2YUhXxHYPd6B8JxXJGC1S8vT9JMlaJecb
 kWoyEc7O5zxTPV4vmbxRxei8VlTOJWdp62Ot4WNuhY7YCBQ9xgYSUgMZ5z3rTNt1HeWD
 d01o+a7kaBJw+4ZFfju/VkxbdKI1j1RZ8Bdxwz5TxIuzIqgyH2L8kLiLwguFQVilDVpu
 a0aKQ2kAhXcNktWjN+GgeuA1JepS+xEcAiensJskQp3S5BHHpQJoPYrFtixmIhYAtDQF
 rUlTsNhBidi9pqExxKSxR1J6SCdvxW1NLYAHCGf5GPlmUQUOUK5+9lzFNIzlaYIzP/uN
 A9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iyMQ9Q6WVC3soZgK45G5O9XRG7NpcVMhl/faXgHekEc=;
 fh=1U4gzvhWJZ0z+Y8NBoBNchQJX/4Nu7wLGrXlMBgJ2lQ=;
 b=hVewe29WyOKRB2tqTibnd7D4cS0PASrtpeaKCiaPTYL/1wyIqpO2Yu9hewDDdIbcp3
 VYtrW5MyNF1jPVZ3VP7KbjXPRPXd5xtKhKRp+P18Q61t48rXc3RpxQxEWIxSXUhNdxRT
 S/f2VNF5FSyDjwtODugoSLTOcfWYclJBPPLN94of3t+TJYSPHaZjkMRbP9AYFxjJpmyy
 VPIxrvIeTAvO4OYhtEcyvRfqtOPeItXyIWT1a7yXcByZS9IQvm+ekEb6gLyyNhocxrIN
 3gAFuQrkFLsHewny1xlHlyJD2bzoYrLkCDWrMEMVyhxRdjXxcjXKStYjDVww8eQ0HgAH
 gB6w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783545803; x=1784150603; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iyMQ9Q6WVC3soZgK45G5O9XRG7NpcVMhl/faXgHekEc=;
 b=n0jqMQCelSPk1POxHurdooBgKoWcNLNtq7SR1td13S2JEIrB6JhaSrctKe2iiXLHv8
 21ef6qp82i1RpsVZRGH/sFAw1L6bALTsDrAJNMCDeOmYKnbWReV9rsqrs0rTs3koN3tz
 QkFibuTymFUorI4LTe3Eylr7M/ieoz2uRq1NTJbuqrfSUtjwlrwHw2+0eE9bWSAOEo43
 GRNJr8xQFbAMT4keRMN4ngpUgSLlf9zmMIVA39LFuxcXLPcrlr38HhTTDO6KTaDElipH
 kn9HGxbPams7TgGINQc7RVVnCaJVMqkwc9Zq/AXJwOgckD+YaI9l/k+/gUbH2/w1yqdt
 8riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783545803; x=1784150603;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iyMQ9Q6WVC3soZgK45G5O9XRG7NpcVMhl/faXgHekEc=;
 b=ZjbtG812JvQ/m/UvMae28860X4Ceceko1BRkWqjvHTw+hMJmfi4m2Wqt7zdN+/et+I
 XppC7WUAmz7DxtYFDzkjL09TNU2Z2re0kAxFY6jPHNKfCq3TvE3eoIoSy4DfWKVKXv0V
 /t6bXpJATA/y+DDGI8Qaxeo3BN8Bl15bCq9gtwlj8FNuTuCLQVhWQD6B7YuIFVk4fSn2
 5FEsn+/AuCBYy0U9HaFpn6dfh3JBczY65p0E7C0SFekAYoqxGUjLEJ+p77v/Ns7YJLu/
 fWMymn+nZ33bnGyorfzuPqxrcNY3DLMkeypE0XcoKX//fEU8MhdqGc1bgkwuUSSAc6M5
 gwHA==
X-Gm-Message-State: AOJu0YyeBHBz9rCyMMMwLSs2n5u5X5XBE4Md2q+17mEua2b9QlNxWjkB
 +I3bfeB1pa6FKcPfVvFHW9cBg3WErxSzXIxBrnBvoS+lg1FRPaVIH2RVr7xf77KUGYpvkssZhB8
 QnlExAvfnZWeflSGNhj/YvaS+w0IV924=
X-Gm-Gg: AfdE7cnKVnYjYUYqKzIACMBYPkSD22VoAztfUkgOOGtbkwhkZr8uNt1q4WlrDbJyiC5
 Q71MLKEE4rC2tMwofT697QzvgINZi9uZ1BfBJAghkKEzRPkwDfOmeKYt6Lm10yl/pp5KG6sFS2R
 65hy/E0ABlNMrp9/+mPmV7CV7EZlfeU+dpxlrhV532EKOAjBGkzZcyLEoGw1E5mGXRV3YQb8P/d
 njiGYMj+tkecSUebVzUIzRu2xuQKI1azhnqyHzjJ9gfgrZoBiEXCicMLbuPO87asiJZDStw9sAS
 q4O2blis+FMGB82FPcfPjJ+dLKqL8A==
X-Received: by 2002:a05:600c:1d99:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-493e6894944mr43924415e9.6.1783545802574; Wed, 08 Jul 2026
 14:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260220192510.37163-1-abailey@iol.unh.edu>
 <20260708142835.780873-1-abailey@iol.unh.edu>
In-Reply-To: <20260708142835.780873-1-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 8 Jul 2026 17:23:10 -0400
X-Gm-Features: AUfX_mxqN886eGPS25GO7bFdjKvY9IfgtD3fJfrsYDpUm3yrNNgUR60Uh05WnYE
Message-ID: <CAK6DuxuJPdvbUymtVdr1OUvSV=NKWSiNpUGS9fErYBT8MCzWDA@mail.gmail.com>
Subject: Re: [PATCH v5] dts: add support for no link topology
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, knimoji@iol.unh.edu, 
 lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000000d0a10656201ef6"
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

--00000000000000d0a10656201ef6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 10:28=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Add support for running DTS with no traffic generator node and no ethdev
> interfaces. Some applications, like dpdk-test-crypto-perf run without
> ethdev interfaces and no traffic generator. In these cases, it is
> beneficial to remove the overhead of creating a node and ports that are
> not used. The specified build option for ice devices is removed since
> the query to sut port ingress causes python to crash when there are no
> ports. Notably, since this is only the case in which there are no ports,
> traffic will not be sent and therefore the build argument is not
> required. For these reasons it is skipped when running a no-link
> topology.
>

I think SUT should be capitalized.

I do not understand what the final 3 sentences are saying about ice. I do
think I understand the code, which is saying that when the topology is
NO_LINK, do not build DPDK with 16 byte descriptors.


>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
>
>  dpdk:
> @@ -58,8 +61,8 @@ test_suites: # see `Optional Fields`; the following tes=
t
> suites will be run in t
>  # The machine running the DPDK test executable
>  system_under_test_node: "SUT 1"
>  # Traffic generator node to use for this execution environment
> -traffic_generator_node: "TG 1"
> -port_topology:
> +traffic_generator_node: "TG 1" # see
>

See what? Is it supposed to say "see `Optional Fields`" ?


> +port_topology: # see `Optional Fields`
>
>
Reviewed-by: Patrick Robb <patrickrob1997@gmail.com>

--00000000000000d0a10656201ef6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, =
2026 at 10:28=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.un=
h.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Add support for running DTS with no traffic gener=
ator node and no ethdev<br>
interfaces. Some applications, like dpdk-test-crypto-perf run without<br>
ethdev interfaces and no traffic generator. In these cases, it is<br>
beneficial to remove the overhead of creating a node and ports that are<br>
not used. The specified build option for ice devices is removed since<br>
the query to sut port ingress causes python to crash when there are no<br>
ports. Notably, since this is only the case in which there are no ports,<br=
>
traffic will not be sent and therefore the build argument is not<br>
required. For these reasons it is skipped when running a no-link<br>
topology.<br></blockquote><div><br></div><div>I think SUT should=C2=A0be ca=
pitalized.</div><div><br></div><div>I do not understand what the final 3 se=
ntences are saying about ice. I do think I understand the code, which is sa=
ying that when the topology is NO_LINK, do not build DPDK with 16 byte desc=
riptors.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br><br>
=C2=A0dpdk:<br>
@@ -58,8 +61,8 @@ test_suites: # see `Optional Fields`; the following test =
suites will be run in t<br>
=C2=A0# The machine running the DPDK test executable<br>
=C2=A0system_under_test_node: &quot;SUT 1&quot;<br>
=C2=A0# Traffic generator node to use for this execution environment<br>
-traffic_generator_node: &quot;TG 1&quot;<br>
-port_topology:<br>
+traffic_generator_node: &quot;TG 1&quot; # see<br></blockquote><div><br></=
div><div>See what? Is it supposed to say &quot;see `Optional Fields`&quot; =
?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+port_topology: # see `Optional Fields`<br><br></blockquote><div><br></div>=
<div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:patrickrob1997@gmail.c=
om">patrickrob1997@gmail.com</a>&gt;=C2=A0</div></div></div>

--00000000000000d0a10656201ef6--
