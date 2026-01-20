Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5AECA5FAF
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B38140ED9;
	Tue, 20 Jan 2026 17:44:35 +0100 (CET)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id 7618540E0C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 17:44:34 +0100 (CET)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-78fb6c7874cso61072777b3.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 08:44:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768927474; cv=none;
 d=google.com; s=arc-20240605;
 b=gblXxk3TpV4IA33rhhCb4NHSQJFHFockZaY/3slNJpajvZNjjcsoicZnn/x3Ht09sk
 xKOIM0FH87VqQxrNlcaQD9xd4RmTrJ9CcCCxVqt71Qh+KaDTDFW/1tbMG0in9lDUzNFQ
 Dn5dKf+10AdV7+oHJyxedxfmy736NlnwN2+cnUtQErkLvtpWikfgAKZcwPXIa040GT81
 nbgjdU2AqcRN0KgY52UjrjgktfbgEr7zDni8w1RjgfF0xoS9gs5dlBwQI1jbPyUjY3sS
 8PKkRoEz+JxP32iBFcgIdVF0uLp8+j/umSORgiqQStROgTfna98UDFTOnqHutQoY1aas
 5tmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=deY47MvamS+bPYGiB6svbPQbfPPX+uiKR8NtAWqMmQs=;
 fh=wpRe3xXGYKhob8BnCa0exZrsX3zGmQZrh92Qq2quSks=;
 b=ANHdEUs3JASJBHlsGSyyIvNRaWk4kLia0wjTSZTjDmrBhG1zQ844TM+D+4aFEb0m7m
 G9h2+O8e46FNMKpoJ/oPmUiNgEO0n4cubFfTYv0ABgUFfT1S6g7OamSKqSVcAljrfTlS
 wMhzV9pV9PkE1b/71O8RWRk67HC5HzgeyiTm7onMUcES59KuVGo2Oi8i5wSxZIQ3HKsI
 fDbT3M07/VbnAyLMsRNhAW1tCLMcGfhWSMH7PQXCyQGVih3j9wgn0oRsvoBhe0RnmP9y
 TKXyIa8wh5MdIvd8N5faKAI7ULnf/3JTxGsirDSmWGGOgrg9Sh2J8CaTiHNacbMqF5xp
 PPvw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768927474; x=1769532274; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=deY47MvamS+bPYGiB6svbPQbfPPX+uiKR8NtAWqMmQs=;
 b=Toh4X6uqZpwUe3Cno/phjLI9pz7hRnlEmg/6FEZly4X9n4BIkikKVOMROmEI6dQ1IB
 KhSwkf7kDyS1At1FDr7g1mxDe7U3QV8eZ4XQ3BA240/MtkJdYhJPCeX6UWhK+lzSgyG0
 zopzyUjuDAn1Mw6PekvmcpifKLAZhSs0hkJrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768927474; x=1769532274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=deY47MvamS+bPYGiB6svbPQbfPPX+uiKR8NtAWqMmQs=;
 b=qYX0omDO0XKwjaiP2pmrqfbMyqr97TB0jtEVv9q/XOg7MgrZiVR7xAZDkH1EXvSlIN
 4hrWFowDoVNeM7QTRK/jI5E1RfaQp1IRUEBZ7iTUtsK5JS2MM0XCTbKqcFZSUj7SCQnt
 cS6Nwst3r/scIBoLE9ywIFZcoOVIKS/LeprHskarW4RmzIk3ZuIzYdRs0bn/pYv5l1kD
 IYAD7VHMCUXJuEdiGaD7nUiN4TQF9F6qc7iex/sY6dGjS+1OA9kX8rSE9vAbxLXRLwg1
 YrSfobUlR9ehyDNq7lMFle9N5XwhZJXzR0MKpXrRPbY/IxtDvySexmdeho2L9gwuJTol
 6T/A==
X-Gm-Message-State: AOJu0YyLboSImhwPH1zdjoYLI9y347nVnmfBawqTO76PIHZn2GuRPpIK
 AF+tzN0rPbycZiexExPqK0PU3H4qxX2W4lCji5A0UdrxT12i9iFqvl4bI3+xYzHadwFKNSgTQZk
 a6Vbw9LlMcWCs64Mlv7mlmeDyI/ss7Gk5hRd6n9S09A==
X-Gm-Gg: AZuq6aK/LJRAwybRa9YcVyLUUfBDiOxsduGvllW+TXvHzvd4QRJV233ce/nweI/f2kX
 4ueUKV8Eoaqnox9X9cc43yzgA6PD1y/jNpG4KzxoHVGUJOqGdNas+I5reS0K+zeRYTBsQ4G/4mF
 MqBXPKiCrl6th/SwYdK8RulSGd/emQeRzYz50HZ9qPblYir5Xjr/J6ZbLBwV3EqxF4MYyqOBXM+
 tgR40Z3qZTtqpMUdh3WhWyo9bGSmOk3lYa6ZOMXps8yCP0uTue6LdF5fsV5+SNVb9eQUQmbC4qJ
 1Mbl/cU+cw==
X-Received: by 2002:a05:690c:60c1:b0:793:cf6e:4d4c with SMTP id
 00721157ae682-793cf6e53c9mr107078367b3.4.1768927473601; Tue, 20 Jan 2026
 08:44:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768518003.git.sismis@dyna-nic.com>
 <366f384e90cce0867652231494d8c873066b5fe6.1768518003.git.sismis@dyna-nic.com>
In-Reply-To: <366f384e90cce0867652231494d8c873066b5fe6.1768518003.git.sismis@dyna-nic.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 20 Jan 2026 11:44:22 -0500
X-Gm-Features: AZwV_QjaatHLUEcCfKnWvfHYsqraEo4qy9DePAPWAhH5jdh5wmIKRZFadNy4LHg
Message-ID: <CABD7UXOQhNLOHQD75hSG5G38v=vCtbZpCcZDfk8SvkGj9nUuRw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] dts: fix invalid f-string syntax in testpmd API
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org, stable@dpdk.org
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

On Thu, Jan 15, 2026 at 6:02=E2=80=AFPM Lukas Sismis <sismis@dyna-nic.com> =
wrote:
>
> The f-string syntax was missing the 'f' prefix, causing
> string interpolation to fail.
>
> Fixes: cfd851f264 ("dts: add QinQ strip and VLAN extend to testpmd shell"=
)
> Cc: stable@dpdk.org
>
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>

Seems like the commit message is a bit misleading, otherwise looks
good. Thanks for the fix!

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
