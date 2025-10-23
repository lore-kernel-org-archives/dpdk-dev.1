Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EE5CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 07:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD53640276;
	Fri, 24 Oct 2025 09:05:07 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by mails.dpdk.org (Postfix) with ESMTP id B6215402C3;
 Thu, 23 Oct 2025 21:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1761246586; x=1761851386; i=markus.elfring@web.de;
 bh=9mBBuJzWN1OIhox4hwBdeLqRh1dxxzZ3agtSRpm8dTs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Mq4g1P3O6e48+JM4J4e0FAH9X19UrH+70CFg4Ydt/L04Esd8/9cb10G9Mpt3SqEk
 SedXEv05BZZpz8OXXdTemkw9Vx/lp9eQPt2ZpZ+TcFH22UTipUk8ZQb/7IBQ/uxxo
 8OwXu84qR/LWqpOlr3O7VrQ85+XNHXygFOJkgCDZAcwm2AuJhX2h/SiefbBXTHifN
 +3tHsU2+dnGZ5XTn8h3uD9nVdFKCMiy7DC5hYd3T8OT3+KqS1Vb0iWoFU2Z/lhXp3
 7Bpt9tR2IkMKmjgzwHhHb6eQqQCPgWhlkVajvwOdkBLwEH9Y1S6i9oZUBtdEvSOzE
 /tHDd0FRsEaDK8UBcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAcpW-1v0y3t3lxw-003Mmv; Thu, 23
 Oct 2025 21:09:45 +0200
Message-ID: <1937e743-df42-47b2-8eaf-5387e1d704ce@web.de>
Date: Thu, 23 Oct 2025 21:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Doug Foster <Doug.Foster@arm.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
References: <AS8PR08MB7339DA678541942C52F92D3AE5F0A@AS8PR08MB7339.eurprd08.prod.outlook.com>
Subject: RE: config/arm: fix inconsistency for Neoverse N2
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR08MB7339DA678541942C52F92D3AE5F0A@AS8PR08MB7339.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n8PczrZ2n99Cqb+Wx9No9ZzD9ievhj9Weonbhe3RaU7C5wtuI0s
 plI3waUVikNsQ7Am1KF/2bKY3g4vE+Gbtx2iVJGpbBUiIkbuwfAgxG+EqS0ggmFG9Lp+8FH
 oRM3kpQvCr4PQnUROVpJGcwntwEYylRgqGzfeE0DClizG/Y0/0w6mlGR8ELN9+HpShmtTnW
 1lHzjWoOhkCWouBLWBG8Q==
UI-OutboundReport: notjunk:1;M01:P0:4Wg5yguuNkk=;GtOzi+bj1ayGeyu9q2NDOKEs6uN
 +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
X-Mailman-Approved-At: Fri, 24 Oct 2025 09:05:06 +0200
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

=E2=80=A6
> IMPORTANT NOTICE: The contents of this email and any attachments are con=
fidential and may also be privileged.

See also once more:
https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-=
disclaimers


> If you are not the intended recipient, please notify the sender immediat=
ely and do not disclose the contents to any other person, use it for any p=
urpose, or store or copy the information in any medium.
=E2=80=A6

Do you expect this action to happen more often with your information?

Regards,
Markus
