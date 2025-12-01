Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32181D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 16:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 480F540268;
	Mon,  1 Dec 2025 17:00:32 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 936C44021F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 17:00:30 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-29555415c5fso52979935ad.1
 for <dev@dpdk.org>; Mon, 01 Dec 2025 08:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1764604830; x=1765209630; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i3KRulO/IP2pQ4/zHb3ntaTpLzHbnE0BC68X+nRpV5I=;
 b=Zsxmp9IDZ+GUpQiYLFSyUf7yLbKdqTvFu7L663ua6LjfwoTO8X0RSe7F43KopvVS03
 smmp53F+H4N5oZhGyR05Is0IMJxbtJNkItrr1PQPPAcjddZXwUR8k2t3sStJ97sVb81i
 8b6ZjDsjR4CPSq7Tl49z/YNmx7U8m/SUErdGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764604830; x=1765209630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3KRulO/IP2pQ4/zHb3ntaTpLzHbnE0BC68X+nRpV5I=;
 b=QNueKEm9YhUTk6ON2Wirhr/MoV9MUTgmMbOFsSrB77eFwD/PKg/Aqt00ZlP8n/1kNS
 qjfgTNZov4EiGx2oYUnY+dT1U6i82V+fNEwV/6pXG0+cG1TnUB6rLJ7OOMsjK4mweZ9L
 9rRm6o1IYxVcddCiVTedbB9+wrAaDqz2jb1kEQNFz+LYEoDeRV21HAQG9G7aGjVcFwgx
 wdrBZOvntcZSkCTkouToAbshVP7nYdVcGVoUKzqTK4x7cEHAj93NsIi7++3o0ChUDxvY
 bRczAXKMxCCfbdtiWOIiXaC1E2NEUOLxJD8MNZPgl9bFL9ktuwqPE4+sFUfyi5GAI0NY
 BBSA==
X-Gm-Message-State: AOJu0Yx+IHEinMPdpodTRmgz1/PMZCstUzGV5y9Ic/KyGhKkBu/pFEnY
 4apnK21FWli9fkJbWEELaVbZBEWIINhjQg92jBL4vOTt4HCf9RKcGtaI/kkk0uTu/vk3uCNg44t
 GUPa1EfPIjCIqAnWpT0K97hPqVBH6bUKZia5nJ5bS8Q0FRQ4UiOZljj0cTA==
X-Gm-Gg: ASbGncsPYy64JruI78ovtHieVGJsa21/DUPiuOpi1tDnt3JpXZG02m14fDyUCiHtA8E
 y/2J8uvZkaYWWn4jF4a4WjMTCSWT+HssomuJmXAgEKYU11xuetzkR8THDapURZF32CPbwKCdJqW
 1ji3uA3VUakis8jz2bu1LyFaJSKNZiFcsMiqLXXsWBZKBq+9EqB1AWaGZxqUr0/6+tHMQyVoVyO
 1uIlh+OAJHKVS5O0CkqPgIiVDp1NdWcikAP5lpsUzW5+7+ubCjOrTVli4EdJmUOZCL49EUloqpH
 ZY5fZmHB3ydc1sDDOs0dsAcjcdaC
X-Google-Smtp-Source: AGHT+IH7iQp0L4BP+rD0R8Xv35fM4yYm/v4oXItEQOBDAE9NUZiyxvbUxC9DP8RhJX+EwTv7IoxmRwzK97MAaSFPJ+M=
X-Received: by 2002:a05:7022:f217:b0:11b:9386:8268 with SMTP id
 a92af1059eb24-11c9d86f163mr24710965c88.45.1764604829574; Mon, 01 Dec 2025
 08:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 1 Dec 2025 10:58:58 -0500
X-Gm-Features: AWmQ_bktDG3nEG2f5pKxCLDM2RgzQ-gtvnyHC5qrqW11wHh2JE-HGlJJg-gyclM
Message-ID: <CAJvnSUDb2yhN3Lb3JKBA94GCUH2yMPcu0cKiKK+t6S2yWCtGUg@mail.gmail.com>
Subject: Re: [PATCH v3 00/31] build DPDK with Wshadow flag
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000093db30644e6144f"
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

--000000000000093db30644e6144f
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

Putting in a retest due to an infra fail at UNH.

--000000000000093db30644e6144f
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Recheck-request: iol-intel-Performance<br><br>Putting in a retest due to an infra fail at UNH.</div></div>

--000000000000093db30644e6144f--
