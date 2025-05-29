Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E488C5B549
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 15:44:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48235427B0;
	Thu, 29 May 2025 17:44:30 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id DF21A427A7;
 Thu, 29 May 2025 17:44:28 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4a43e277198so3058371cf.1; 
 Thu, 29 May 2025 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748533468; x=1749138268; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WnKUoCzqaJFfNVxYeIWu61FQXQoFCn/SaAXID/q1tM=;
 b=QToZr/VDW3T2dVyOSDoTO2gIqj3TkqKd8bKTn4NVLbvdwZ6l6wfKkOKb2Of1PtRq3u
 4eI51PLdpnF9TLyhe8wrgNZu94iACgIMYgpw8T4qDgmhmWc3NgHtpMG99ySX0/LBzSmq
 KKrE9lMvWE+b6A4urZxBtCibvk8dhcalk3hDMIe6Qc2sRcNUpb5DwM/F2QIt7OU04A6z
 kG9dLeZ8kQT4Qb85CbZE3NfV5CBeB9/YX5QPxQ7lKqo87O46QmhzMQWgdpYCrmtbPrP4
 G619wFAwGPSW713aIplE4mXonDVVC4/rqLNdwXB1+OcLnCz0V/EwGMoWxUg2hYb8wrO3
 3AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533468; x=1749138268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WnKUoCzqaJFfNVxYeIWu61FQXQoFCn/SaAXID/q1tM=;
 b=iJUBuAKgYYQR7RSSl95PHjt6EMETy+fRFG86yOKlLG1DzalzSN+CmUaZ/rYgwzlAn3
 sDbV6T2muaH37ohyuFlzC9q4BX+GpqNgOdqshQQIxsS9M/pXzbD8pDClzUuJAEV3aw1o
 6rWNi5vRslZ+kbE2a6EXsQnI+O4YWk/0zLgEUOw139EwSh54r3jm1EBmKZVcB69gjrSA
 wgwgOrzdgiAE7G8IAa8ZBA2eT1ZYDHDoo+c5IBraPrwpzARBfS94tnm322xaJlMSJuGS
 2L3ui/CEari29G0m0nPazjvNa6SOmM4R3B1gjjOqEPTaBKvQJnpAEtMf6xByfOfTs1D2
 GKXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUekxE7dWZqUSJlkc6+8rMrD66JovRzO+IHvHBzEMP71CkVxrtM5GF+BJ5CXKNq0P/VBoI=@dpdk.org,
 AJvYcCW1DTEeqmHzndr3qm9vW7DzL7S5l5+HczU+Q+by4A2YtMXRxdWPMXBogzjwEPMcdePoIC1eT9Pz@dpdk.org
X-Gm-Message-State: AOJu0YwY4x3MHBW2IywuQpsSZuaP8U2Q5S/McNFKD9sswh3clByqggc4
 69+L8zHY+hQlqSo+oGvdag7qGMQOsQVhLkjSr6Cf225kkA1/fj9tSwjG0Lei2BXxS13wwp0Cpa6
 6YNLYbd2wbTvup9Sk6ISDtDp5DaPy8KkRIISd
X-Gm-Gg: ASbGnctyknfRDXTr/x6EEODlK0KWjcsFASLjH6PW6IzgaxSiM+y8lyJPI+St5Ww0uuE
 X+jFURX/3kbpg6f77ZttW5nwVYUgcFKoBZb/W8TrJmqIMNGMiRMiFH2s423eocNK0T5Hb3x8z/P
 hWShB2JIXRgY5uHu4sOXk8q77wL62gs6s=
X-Google-Smtp-Source: AGHT+IHEz85RxuttQobSdqs2kECFn2nuT/CIQ8WzZV08C9MtqxkfovTsasrq3axtZWsXvsxM1CWkr7QhXPU+mdSvH6I=
X-Received: by 2002:a05:622a:1e0d:b0:494:7e12:3af1 with SMTP id
 d75a77b69052e-4a4400c898cmr1752541cf.36.1748533468096; Thu, 29 May 2025
 08:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250409061152.1096849-1-skori@marvell.com>
 <20250528062104.974392-1-skori@marvell.com>
In-Reply-To: <20250528062104.974392-1-skori@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 29 May 2025 21:14:00 +0530
X-Gm-Features: AX0GCFtt1TQoggefWrqh-hGnGGlF8J9rQOb-YiosIR2ApIipuK3uhuOdKUJ1ubQ
Message-ID: <CALBAE1NZG1DpRWGvM_emADLcP69pp_fWDFEKuRp3ZKB3p862EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] net/cnxk: mark invalid MAC address if it doesn't
 exist
To: skori@marvell.com
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 dev@dpdk.org, stable@dpdk.org
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

On Wed, May 28, 2025 at 9:57=E2=80=AFPM <skori@marvell.com> wrote:
>
> From: Sunil Kumar Kori <skori@marvell.com>
>
> When user requests to configure a device which is already in
> configured state then first device gets resets to default and
> then reconfigured with latest parameters.
>
> While resetting the device, MAC address table is left stale which
> causes entry update in later state.
>
> Hence marking the MAC address entries as invalid to avoid any error
> due to further operation on MAC table.
>
> Fixes: b75e0aca84b0 ("net/cnxk: add device configuration operation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>

Updated the git commit as follows and applied to
dpdk-next-net-mrvl/for-main. Thanks

    net/cnxk: fix invalid MAC address

    When user requests to configure a device which is already in
    configured state then first device gets resets to default and
    then reconfigured with latest parameters.

    While resetting the device, MAC address table is left stale which
    causes entry update in later state.

    Hence marking the MAC address entries as invalid to avoid any error
    due to further operation on MAC table.

    Fixes: b75e0aca84b0 ("net/cnxk: add device configuration operation")
    Cc: stable@dpdk.org

    Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
    Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
