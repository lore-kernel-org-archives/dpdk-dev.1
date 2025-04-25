Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B998EC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 02:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4F8E402F1;
	Fri, 25 Apr 2025 04:42:40 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 75AF0400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 04:42:39 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-af51596da56so1299864a12.0
 for <dev@dpdk.org>; Thu, 24 Apr 2025 19:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745548958; x=1746153758; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XmEvf+7kEfxl0yULqjw2T5EtuM68yyEdVotQcMpnIfg=;
 b=c4G4TBNnp3coIlv7ERg483NhuUwWojekUbEWSyReKFiCW+6ax3jgTNk9saLG2H2KEY
 nh8yClrp+5/MIGSvW64dEIMZCH+BuKFsViWiymo3JoYP+IDoDSiZvdvpC/pjhJHAtM20
 nO4UcCm+RHkCVi2nj1IsKdGE0gou3XfvslpNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745548958; x=1746153758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmEvf+7kEfxl0yULqjw2T5EtuM68yyEdVotQcMpnIfg=;
 b=Mpnom9Z34ViulQmDEW3q7Ivy0vp5lEDV3adUX/KB32M6oaICb3MtU7c46lZYG+kHve
 BxnX/ZUZ8cXghPL4ts7O4YTVRJ4KY8fSHmWzAl34e7+50xdxhu85X5XFPmn3Js+CKXVt
 gbtg+tESG5c8whlQdvm8N8tJHKG31oirqoXnQnfQSoe7wIDhCFOpW9TjaIt36QTebU4g
 FDbyBhy7Gonxozayy4tuaqKX9QFOjH5PVDiSC7VYjCV6jJbijSD9QCfuVwexX3CJC7Xa
 lJ8C1lK6rKRxAxzXeDmcP4YYlNpBd+B0h7LFQ6bPBqPjC3/U2bYN6tZI3Uc1BU44ARjg
 lZrQ==
X-Gm-Message-State: AOJu0YwWg9wBXcZmuCEDpSdnVo/0WrZnnwr2KWsjydtj/Jwsj3gh6vEa
 45D8j+/GhywwvB/A7vkfmi3pqb8ssn2+d7X7lwuUT5IVDAIwSV0fZIZ2zusDYknatPztGmQB8GI
 nCdHqyfE7v7nyEDCypuWAODkMgE9v1vRHefgBWw==
X-Gm-Gg: ASbGnctAAzVevOpMhibHfffKZTVTzZGDmE6Jv6MLBZ9DwCbhHT5c/V/81jEfh2u9TaG
 n4sCrtL1fp3Sk0Ct2d93srSUFtM/6/17bJRbTpbUIX53xT1FiU2EhVOOc9KLQh0qacpB60cb5GP
 iXioKClBDtZ9h1w+GXxwgLLmPADptZ4+W0noi9zg==
X-Google-Smtp-Source: AGHT+IHl6RYxEuVScP60kwkyHImZvElHGhieVZovLC4J2LNqD9dAlBgu0FQstEpKYQAaWEDB39yax0JXajkCJldAYIs=
X-Received: by 2002:a17:90b:5446:b0:2fa:15ab:4dff with SMTP id
 98e67ed59e1d1-309f7e8ec65mr1092554a91.31.1745548958539; Thu, 24 Apr 2025
 19:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-3-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-3-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 22:38:15 -0400
X-Gm-Features: ATxdqUFL_JHTEpqj4CgG9Z_Me-go7PR_SAle3TqHOvNxELcrAIB8-Ndn4lEQW9Y
Message-ID: <CAJvnSUB05Kgv7BWvTwOsqvOKO0X9tzMD8FpiWZ35JyLPriqMeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dts: add blocking dpdk app class
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000009cb6250633914939"
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

--0000000000009cb6250633914939
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000009cb6250633914939
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu" target="_blank">probb@iol.unh.edu</a>&gt;</div>

--0000000000009cb6250633914939--
