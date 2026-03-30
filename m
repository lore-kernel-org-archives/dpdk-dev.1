Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4377C1061B1E
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 20:38:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79836402D8;
	Mon, 30 Mar 2026 22:38:25 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id C3C9D402CE
 for <dev@dpdk.org>; Mon, 30 Mar 2026 22:38:23 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2c18af885c0so5082650eec.0
 for <dev@dpdk.org>; Mon, 30 Mar 2026 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774903102;
 x=1775507902; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0G2u7FZj1fqEcSqm7ovH6UWtwenho+j/Y30/2ytPECg=;
 b=GvTMkj+X1+Q6ma1OFgexxoXWkCKG02XdSgfurz+YZdgyc9KYnys63S9mIPGIz3Mi26
 NPB+jIokVh6fT8A8onMB+izwGdr/wdjapJ8U+C39Yg/Ozgj0LmKU2LmhRNFb9HrzZ+nZ
 JzD8jlsdfPqaLqG9RBNtciUrBWZLGevUF8GZ+9953FHshz7XpQXvn1BWFQNINhD6+UxS
 eu9jdZUG7UKsC1Zln+FHbxYwtiEN1uYkYtTUqRBmgAgVRSe4qfWcSq87sfYDF5EX7Iib
 VaI3mlImJJC1N3Fb1fn9g6xkRWhYqIIPuChDQ5sEnoqIiw7gBIR/JF1lwjHKiyshvgRt
 5NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903102; x=1775507902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0G2u7FZj1fqEcSqm7ovH6UWtwenho+j/Y30/2ytPECg=;
 b=l6MnJUNKkDdio9wMhjliBHHR+7gZomNkyiUXg7nYUCw7CGQJdfkMfZk3cUYTbTLgFt
 WtPqTydeLtA/g6obHcHVB91N/Torh5swmTKXwS1jo587h8iYPsMamil11YADQdl2M6gE
 tydpblSyO86E2M7VfhYvCJhsD4qeVRWhFolTFF5XuGbToOBFSOfcsnixzPN3g24QLNcv
 cO0XXcLs1Yt/LcxhIER+zdpAvqROTMdoz3jqjTliQdFClEwQ/wKQZ2ZjLb+2Gy7WBkKZ
 //zFDRRBp5PWFil43rct4sxDx6xSlRgKXWpr49Q4ZRCgFf1yf9mjISH7JSUvUUf9U5e4
 Yo0A==
X-Gm-Message-State: AOJu0YymDmwZp8zV0Vk1ktOMQCPLl8H1MFb3Plt6N5VxkLv7nC/wVIYy
 Ta964GhJ9d7tDzl0CK1vS9z4zXYh4aq3Mltq3uL9oGTEHxfYtJYg0FjsEQIds/2m2oY=
X-Gm-Gg: ATEYQzzgcKCUyJeQdIpY2zJ6GY0kssHnNhXhsbcTmnjwSC7Tiq5rCq16AASOs8nXlvr
 vwT2KbhwMjOTKbbZU9ZUcOAhhW0nzRaXWUdVoO+EglhbqlNC2W83uWRM5gBEwyEY7RE+5jJJnw/
 W768xfHcJtmMzvqKc0Ag/H4HgT+0+5+wm+3uT+PllKXqxUsU5P2SIynF5AYTweIKgHBIwiGIbK1
 o/hrFZByfwje7QtOwrIeEf59EOOF3sXNTh7iPYL0KUWGAT8gJl5YJF2VYxT+7mCnebR3i5r2nOs
 +xHUJB9iQmk31g7IVU0qNjvwl53QwQmkXt11h2jkbSaBjtpGWp1gAZ/xSEAqX2kJ6sS+80yENs5
 aw3TqZbuLjnd5nxlTkHfZh4LuLKdpOH2fUWD6zCgJXgSrkA6whqC4OlYxIiBmRMBLBmCvFncFBV
 TB6euSpzMubQNHW0EpyWfAmyWozJOrHcRPKmo=
X-Received: by 2002:a05:7300:d0a9:b0:2c4:e5b6:6e51 with SMTP id
 5a478bee46e88-2c4e5b67306mr3156869eec.6.1774903102502; 
 Mon, 30 Mar 2026 13:38:22 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c74825a0sm8185921eec.27.2026.03.30.13.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:38:22 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:38:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <G.Singh@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] eal: add worker threads cleanup in rte_eal_cleanup()
Message-ID: <20260330133819.7219f905@phoenix.local>
In-Reply-To: <AS8PR04MB8198C9AD2F57C3E178B8DC92E1182@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250110064717.1372216-1-g.singh@nxp.com>
 <20250110091902.5139f8b2@hermes.local>
 <AS8PR04MB81986B239B742A86D9E7F82EE11F2@AS8PR04MB8198.eurprd04.prod.outlook.com>
 <20250113084017.6fe7edc3@hermes.local>
 <AS8PR04MB8198C9AD2F57C3E178B8DC92E1182@AS8PR04MB8198.eurprd04.prod.outlook.com>
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

On Tue, 14 Jan 2025 04:53:51 +0000
Gagandeep Singh <G.Singh@nxp.com> wrote:

> This is fine for graceful application termination, but what about non-graceful application termination?
> I have a DPAA bus cleanup patch ready, and will submit it soon, But we still need
> destructor in case application exit without calling the rte_eal_cleanup().

Any destructor has to use only signal safe functions. if you want to handle non-graceful shutdown.
That is really hard to do.
