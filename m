Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1163BCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 18:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 257EA402A0;
	Mon, 17 Nov 2025 19:14:00 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 0BEE24028B
 for <dev@dpdk.org>; Mon, 17 Nov 2025 19:13:59 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-477a219db05so9373065e9.2
 for <dev@dpdk.org>; Mon, 17 Nov 2025 10:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763403238;
 x=1764008038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oiu7Uo3y0XJJpIXJXGwU1OBZvr/A18P48NIOqjiDt6U=;
 b=dkxgNMnPiozPWr0kxMzw/bSyfDGzUCdBoTSubkenZI5eucir7RgdLpNsv2iwaXvbCl
 V8JCoRrBJfBh32Fb4AjPwzDIPew3aAGkNgOK/8A6jVRt1bkToQ9eZvQRjrEPO+A5XxVT
 bquRAWGPC5MIZShBnpscdSTl16wuaNCRvm/dlir63l7HIxmI+5ZkyJZJsTVHGU5PgTyg
 TlGqiB8Ue0qfoAsyWQkDW4o5annzDJJVrQpOXE3ssrrajckZn4eRgLL3v8woMMEpZVaG
 9JppnEk8xtdwCuK0pYQHG+Nfuk7rK3hYMqaX8D12ZMPnHOScvJQod9F/fi5TxnlM8TZB
 s+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763403238; x=1764008038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oiu7Uo3y0XJJpIXJXGwU1OBZvr/A18P48NIOqjiDt6U=;
 b=TRxzIVUihhIey6ATRG+wMA+SUpqhJxUX9oIN7DWzMxiVsaZM5kjHAMUVkErT0Hz10B
 ioN0bLz0T1X8akGY0f0UFC/ytbXT+lW9hQBZeqvPPDG3+PlqC4XtOuvkY0/rzfq04Oam
 AobvEEx1+nkcnnjcEXkOWFbRtNpzQYorRUu/1BLlBAorsUKGrKPxKbAht9Fi6BfNdkNQ
 imAPVdPTF8+/ovXs5LGhNTNfeT+RdrbOEE+6DslyGUXFTD/a1NKupzKX6jYCoTTWqJso
 MgzsETDjbeyESO8wEgvI44EaZ8gu2DLW4t/o00cx6YrbTw3yJqMycT++wMUsiLHUpL2I
 ccRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBqCWHgnnW4E7mjt9nb+EufeHWgM/pRUEOtBk0XH/LzlQkB59PYu8PCuFmdgFXlZuTiYA=@dpdk.org
X-Gm-Message-State: AOJu0YyBdDO8hg8YVaScezwlz+af9NtjWoWmM97YutSKydjYmf9GKqcY
 MTE3vrctDh976UDwHVFD6IcsqBoGNBEXW2vZQpuIzbFL8lXRX+FO8P2+aoctiv6kvXI=
X-Gm-Gg: ASbGnctUpb2PaeDdItZhxWvSAyfEMVXoxK5KsArUpdHsO800nppgJUdRQZvZg2DsC1g
 IURCey7L9lzpwrs3ho65ZjkMxv6dK7XgZcP/jcoeyAGAoFFkmwuyG2pXSf+J4vP1rlqkp1Xoq96
 auJzP4cimImTeb/5FH1Y34xxgc6DvxQqwsmnv6MgvCkSjDeNF7g0TtYFradS2lBQopaOgFAmiLC
 iHu3t/SYoOU4fSZ68kT9PmW6JKdbRlLZLr5R5GqnuLuFh1EGbRIkYTiWJ9/TlLldPTgsPYyGTRL
 F6kv2vIK8gKYs7DWwisZfR3uYKld0eauR8Q1vys3aclZNoT82BT72smplVwBXUVe4dmve/v0D1i
 8SuTHH8buTHnUj0tQurNJL0usYSHejcdR0vCR2OOnqU+SnkKsW7G6qMXFODmIGZt1L3xuR7My71
 amhhvc2AAQNJN1AW/AGI16pyCBdQfHQq/6um0jFGQjFBpG
X-Google-Smtp-Source: AGHT+IHBcvATNXcFn0Lank2WT6L3EVXJngLN9LdXVkbizQnhYzaS37w95lYFK2ARWy+MC2mWa7xkJA==
X-Received: by 2002:a05:600c:4452:b0:477:8b77:155f with SMTP id
 5b1f17b1804b1-4778fe59ce1mr122448925e9.8.1763403238399; 
 Mon, 17 Nov 2025 10:13:58 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a96aafb3sm552195e9.0.2025.11.17.10.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 10:13:58 -0800 (PST)
Date: Mon, 17 Nov 2025 10:13:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Maxime Leroy <maxime@leroys.fr>, "dev@dpdk.org" <dev@dpdk.org>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>, Jun Yang
 <jun.yang@nxp.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v5 2/4] net/dpaa2: clear active VDQ state when freeing
 Rx queues
Message-ID: <20251117101351.4501dfba@phoenix>
In-Reply-To: <PAXPR04MB9328DD5AB3BD62D41A9E39A489C9A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-2-hemant.agrawal@nxp.com>
 <CAHHRULUv9o76_zkomOi4jYnd3ci7dbxQD2bXmudWA00aVUwttA@mail.gmail.com>
 <PAXPR04MB9328DD5AB3BD62D41A9E39A489C9A@PAXPR04MB9328.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 17 Nov 2025 09:44:40 +0000
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> > > diff --git a/.mailmap b/.mailmap
> > > index 10c37a97a6..d92d4fc24b 100644
> > > --- a/.mailmap
> > > +++ b/.mailmap
> > > @@ -1035,7 +1035,7 @@ Mauricio Vasquez B  
> > <mauricio.vasquez@polito.it>  
> > > <mauricio.vasquezbernal@studenti  Mauro Annarumma
> > > <mauroannarumma@hotmail.it>  Maxime Coquelin
> > > <maxime.coquelin@redhat.com>  Maxime Gouin  
> > <maxime.gouin@6wind.com>  
> > > -Maxime Leroy <maxime.leroy@6wind.com>
> > > +Maxime Leroy <maxime.leroy@6wind.com> <maxime@leroys.fr>  
> > The order is incorrect. My new email address is maxime@leroys.fr, and it
> > should appear first in the list.  
> 
> Hi @stephen@networkplumber.org  will you please take care of it in merge, or I should send new version?
> 
> Regards
> Hemant
> 
> > 
> > Thank you,
> > 
> > Maxime Leroy  

Fixed the .mailmap and checkpatch warning about indentation when committing to next-net.

### [PATCH] net/dpaa2: clear active VDQ state when freeing Rx queues

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (24, 42)
#99: FILE: drivers/net/dpaa2/dpaa2_ethdev.c:646:
+			while (!qbman_check_command_complete(qs->active_dqs))
+				/* wait */;

total: 0 errors, 1 warnings, 0 checks, 43 lines checked

