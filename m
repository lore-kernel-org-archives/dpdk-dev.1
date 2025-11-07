Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F11DCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 04:20:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C4EB40264;
	Fri,  7 Nov 2025 05:20:06 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 609544013F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 05:20:05 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso204562a12.3
 for <dev@dpdk.org>; Thu, 06 Nov 2025 20:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762489204; x=1763094004; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W5dvXz57Fql0RrStth0r0gQ2VgCleuUtL77liJmqI0Y=;
 b=cZW6BZtVFE3atHODgktZEXtxF2bwZbf5oF/qTpbCM1x+h6ZZnstmTqRXCvvHmrewd8
 73UJ7z9kr+kftUs9JnsLu1bxnZQeTznp5Nsc0NTu+E8+NU2Rx5tOvR7hmyvBXyW3WFvb
 Bu3ya9HCTn1UWtO9nv0J4VaHtTAGJurJXUKMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762489204; x=1763094004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5dvXz57Fql0RrStth0r0gQ2VgCleuUtL77liJmqI0Y=;
 b=rRP5pglMiFwx4GEcot4TwERWbOB/uMlD/jTRz3C7ecRzYGat7R7+6XNMftdofYbNgZ
 95AprEveBDVXCBNQHjmMDlvnfcdw6ybtfJ/dvSoAjG8IM37Ljq4Ilu9bj48AALLGZMd5
 ZrVjqgvomlcP9KDAY5qj2akY5gDNX/rklkly6RAtI7cQ9BhWfSlxDUJYXEhXaAzaNIXv
 MWK4wCDhtlvwPPd1+bR7jZknBeD2kU4vOXvwplmtANx3CLsN6bGg47t7Tsvz+bDPWkXT
 9boMZKOjN9eTqLot6WFU+eFLS5noIZdk6W8wNViA1pMhfccJ1sYrlpzsy0E6bIw69KQd
 B+Jw==
X-Gm-Message-State: AOJu0YwHbpCpgZ1dSjXdIm+nZGKH4XNVYmmJApH07JoT/LC82cOdMzWU
 O8rS1LmKtek8lVxsjCgB7Y5dg8tX2Lx6JdDEvxkdk5wf2x2LM1nI8WH2mUpINxzno55C65njC0n
 iLhjzaZ96j/JuS1WsW6/B/oIHCzICW2vGtL8bDjVw/g==
X-Gm-Gg: ASbGncv81HyLND8hFa7Qy857yuhR/cdfaPeKraIk+wXYhN8MHiGOYIEy0YXQhApRjN7
 F8uXTS6Kt5UK7hyMh6yDtdGvHnAj4as1RycWxvA62EPzMo0ZHKvZQf4BNBD+Rc+zWGGcFqF62yE
 SeGJsAsH9dCywPul7TjkFlpH0J2UmGhgk0qIh+ihlLI2O8IcPiCb0jmWBdpxKc3hYA7qBn2In9K
 KS2HmpKDGS/DfXjTOj0fFQkBB+waPEwZhBInkH40AfTv8RuETn3N1jnEpG99X38QljZZXGJjykG
X-Google-Smtp-Source: AGHT+IFGNysVzOi3S30HzrbNP98CkbH2f43WcNM9TqgJv4zuMkEK29vuXqWZ1la8pra8X++ud4/lXKodUJ0+EddS/ro=
X-Received: by 2002:a05:6300:210a:b0:341:5d9f:800f with SMTP id
 adf61e73a8af0-3522ae75fb9mr2596786637.50.1762489204547; Thu, 06 Nov 2025
 20:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20250730125859.159185-1-thomas.wilks@arm.com>
 <20250910193149.1023435-1-paul.szczepanek@arm.com>
 <20250910193149.1023435-3-paul.szczepanek@arm.com>
In-Reply-To: <20250910193149.1023435-3-paul.szczepanek@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Nov 2025 23:18:55 -0500
X-Gm-Features: AWmQ_bltA2_oKJ1gcSG6QEC5vObNc-NIbS5QPnRfbmOIRc84BdHPspB2LvZTF48
Message-ID: <CAJvnSUB8hK6fj=12VndJCWEQOEz6=L5LM9C02Y+yR-kgXp2awA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dts: add PMD RSS testsuite
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Thomas Wilks <thomas.wilks@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000f5324e0642f97e92"
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

--000000000000f5324e0642f97e92
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Applied with a rebase on for-main with these fixes:
-imports now coming from api instead of framework
-RX_OFFLOAD_RSS_HASH renamed to PORT_RX_OFFLOAD_RSS_HASH

--000000000000f5324e0642f97e92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.=
unh.edu">probb@iol.unh.edu</a>&gt;<div><br></div><div>Applied with a rebase=
 on for-main with these fixes:</div><div>-imports now coming from api inste=
ad of framework</div><div>-RX_OFFLOAD_RSS_HASH renamed to PORT_RX_OFFLOAD_R=
SS_HASH</div></div>

--000000000000f5324e0642f97e92--
