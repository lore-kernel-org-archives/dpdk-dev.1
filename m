Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D7CCFA1D
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 16:07:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47562402E3;
	Fri,  7 Nov 2025 17:07:32 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id ED1884021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 17:07:30 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7ad1cd0db3bso740824b3a.1
 for <dev@dpdk.org>; Fri, 07 Nov 2025 08:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762531650;
 x=1763136450; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xI3aHL1HRZ8PdDACJnRqPl6KJgTCd0zOglZdaQZ4aj4=;
 b=pnp4Muw85EKSwlt4WL71PAuABkek/mJcmphX745T3mImwidV1Pt+n1qGFGwq9h1LzO
 e4RydAEAZDwlKNhTUSkp5ZR180gP3wPmO41lq9dRS9Iq/7lBO5P4ACWmj64jgPOEJBgv
 t5/t7w5Mrw6RIrYn9D54Jx/fw47OZ8ZpHBrP6mvx+gpV64VWmnpVcgPQhyzZYemrUxnp
 QhX5icAvY670egY6meNJZLYlRLT2mthERM6ffx168Q988ODx/f33pd+PdHG5jGOASBSz
 t7G3RRwnduVHF+rJSJPuo8ef4AMqtnJeVvLHXo4TZI19UyaGSnER/6e+V1XhT1HRzA6e
 VqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531650; x=1763136450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xI3aHL1HRZ8PdDACJnRqPl6KJgTCd0zOglZdaQZ4aj4=;
 b=AMzc6gm+OegkfN3k5gTMZfE7xtCFGKb/cHPSuW6bbKC725gbzLKTUhPoALmy42FgS9
 FC82cyORJVzQWyVUg9Z8JQQadY6guSG9X9PdLYHUd1OgE68v5cBDrBTGLBZOGwoh6jdi
 FGe9W4uR/IR9dmikXUy1/erSv03vSUvkUUepQk0r4TY++dSpjIi89HK9uhE2JyCe7TlZ
 HKyClU8xTq6MfyWonY/i0OS1Dlm7MgJ0+3sxo1DB92aJapk3Su7yGpkLLxSWuTXlA3W/
 OHk/SzZl9jMKXWs7T/BG7LA2hoK+e9OVWQWE1xL1zwk1VT2fw6fSUEbqwYTHeGEaggFp
 3J7Q==
X-Gm-Message-State: AOJu0Yw9IEGwudYsT/ys+elOWYxdOBl97m0PmTVJJ9RZf/ON/OmQtggC
 bkRPLdze6uqC1337M36TJ2m0FKtUuTDUOw2wQtf/Lv8JBDVf0xKk8oi/Bdqw2zf5NGx/trfmI/p
 m1cSq
X-Gm-Gg: ASbGncsgGKs/f296pDZMJzf1vhAgGerWrqCEOf/YAFPy0xGUrJ02sKHsHwcK3uaHc6e
 +fju9ssPTMSQxWX4alzwBg79xD889cHh3GS4ZYGpFaxBkCeT4GgASkxrhnlaWltRhm3FXU5VvSC
 hD6FS6tuS/i+LB8QMnG2e/9pgSjut4qE5peEVu3ABRBDQ95/qf+MI3yBz4BhjxNmljFNQsr1eR9
 d0tdNdLzDqxuVNcYWvN3e3NelOO/8GNwvskjnFVtGZHJN7tBNnBc39F58e+/z+NGRZAbJ1MrTOQ
 uqMTShZGvbZp8kxlTKfjbt9I3P3CAg34LDuLm6/ksaz7UbNeddJ+JdDrBTSYEHTf6Ma8T1BpG2t
 cgmA6FGzprPUw6PCfOdJu5RI6/OFlQoOSliXekNDGunBQFPt7AvzD/0xgWIk3pBoWZGTKFrHwgw
 +Kkvjmqa45WpVC7IdS96LPqaLD1tcZjf3+Xw==
X-Google-Smtp-Source: AGHT+IH4XDDy2oWOUGXxmqitwS2wL6XexJcdXXFAz+sx5qPNUmqco3oIUvGdCx1/KqXKECYySwsNYw==
X-Received: by 2002:a05:6a21:9982:b0:334:a4dd:cd12 with SMTP id
 adf61e73a8af0-3522857bb04mr5171369637.19.1762531649883; 
 Fri, 07 Nov 2025 08:07:29 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0c9c062b6sm3350157b3a.18.2025.11.07.08.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 08:07:29 -0800 (PST)
Date: Fri, 7 Nov 2025 08:07:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@cesnet.cz>
Cc: dev@dpdk.org
Subject: Re: RFCv1: DPDK RTE Flow Rule Parser
Message-ID: <20251107080727.13e201a1@phoenix>
In-Reply-To: <be773672-77bb-4c2d-ba12-43b75ff29507@cesnet.cz>
References: <be773672-77bb-4c2d-ba12-43b75ff29507@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 7 Nov 2025 15:16:28 +0100
Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@cesnet.cz> wrote:

> Hello all,
>=20
> ## Motivation
>=20
> Recent discussions on DPDK Slack raised the idea of extracting the=20
> rte_flow rule parser currently embedded in dpdk-testpmd into a=20
> standalone, reusable library [1].
>=20
> The main motivation is that the external applications, such as Suricata=20
> IDS [2], often need to express hardware filtering rules in a consistent=20
> and human-readable format.
>=20
> When integrating rte_flow into Suricata [3], we encountered the lack of=20
> a unified way to define such rules. The immediate need was to let users=20
> specify input filters (drop/allow) determining which traffic should be=20
> inspected.
>=20
> Suricata=E2=80=99s existing capture modes (e.g. AF-PACKET) rely on BPF fi=
lters=20
> [4]. Maintaining consistency across Suricata capture backends would be=20
> ideal, but BPF and rte_flow differ significantly in expressiveness.
>=20
> The other options include either dpdk-testpmd or custom rule syntax. To=20
> not reinvent the wheel, I am leaning towards use of the testpmd syntax=20
> for the ready-to-use generic expressibility, especiaily of the network=20
> traffic patterns. For the reference, I am speaking of the rte_flow rule=20
> syntax that you can define through testpmd CLI, e.g., "flow create 0=20
> ingress pattern eth / vlan vid is 0xabc / ipv4 src is 192.168.0.1 src is=
=20
> 53 / tcp / end actions drop / end".
>=20
> In the Slack, Thomas Monjalon concluded that it is generally welcome to=20
> see a new parser library but we need to state it is just one way how=20
> create rte_flow C structures. (Fine by me)
>=20
> ## Library proposal
>=20
> The existing function flow_parse() in dpdk-testpmd already performs most=
=20
> of the needed work:
>=20
> int
> flow_parse(const char *src, void *result, unsigned int size,
>  =C2=A0 =C2=A0 =C2=A0 struct rte_flow_attr **attr,
>  =C2=A0 =C2=A0 =C2=A0 struct rte_flow_item **pattern, struct rte_flow_act=
ion **actions)
>=20
> It parses a rule expressed in testpmd syntax and initializes rte_flow=20
> attributes, items, and actions.
> External applications that use these structures directly can skip=20
> redundant setup logic and rely on standard DPDK APIs (validate, create,=20
> destroy).
>=20
> For a public API, the void *result and unsigned int size parameters=20
> appear unnecessary and could be removed. The simplified interface would=20
> only expose the meaningful outputs (attr, pattern, actions).
>=20
> ## Problem statement
>=20
> The main question is how to provide this parser without fragmenting=20
> existing functionality.
>=20
> I would like to extract the existing code from dpdk-testpmd to have one=20
> parser that is available and used by both testpmd and external apps=20
> (using the library itself).
> I quickly run into the complexity of the testpmd code and how entangled=20
> the C structures are throughout the testpmd's source code.
> While the parser extraction should be possible, I wanted to check here=20
> with the community if that is the most preferred approach.
> Since the extraction moves a lot of code from place to another, there is=
=20
> a very good chance that it would break all forked custom testpmds.
>=20
> The other alternative is to "start simple" with an alternative=20
> implementation, perhaps only focusing on subset of testpmd's parser=20
> capabilities. But this would very likely lead to two places being=20
> maintained independently.
>=20
> Before taking either route, I=E2=80=99d like to understand the community=
=E2=80=99s=20
> preference:
> - Do you even see it as a valuable contribution for customer applications?
> - Can you possibly think of an alternative way to solve the unified=20
> human-readable format conversion? Both on the code level and interface=20
> level.
> - Is testpmd code extraction the right long-term solution, even if=20
> disruptive? Should the private DPDK forks be taken into consideration?=20
> Or should I start with a separate lightweight parser and revisit=20
> integration later?
>=20
> Any other feedback is welcome.
>=20
>=20
> Thank you.
>=20
> All the best,
> Lukas
>=20
>=20
> [1] https://dpdkproject.slack.com/archives/CB2UPBU48/p1759765888891329
> [2] https://github.com/OISF/suricata
> [3] https://github.com/OISF/suricata/pull/13950
> [4] https://docs.suricata.io/en/latest/performance/ignoring-traffic.html
>=20
>=20

Seems like a good place to see what any of the AI tools can do.
Would also be good to use standard parsing tools (lex + yacc) rather than
doing all the parsing with open coded C string handling.

Ignore private DPDK forks, we can't test them. If you build it they will co=
me to the new code.
