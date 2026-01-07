Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82AAD0D17C
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 23:07:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8A334028C;
	Thu,  8 Jan 2026 00:07:23 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 5789340261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 00:07:22 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-11f1fb91996so1528892c88.1
 for <dev@dpdk.org>; Wed, 07 Jan 2026 15:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767827241; x=1768432041; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9G6SP3U40zb5U3l9tFkURSgqGmw5CIlxl2TSd2wjWwk=;
 b=I1m/ouZJavJEbVnXtHh/k3y2kRqGnHoPzYmAe2dnGBPWX6ooxENanhn5wvQJacfwOK
 GwY1F5eABCVNTDo3e1GvCEZFQqaHyKVW0ET3hWGKz6AI0kDzIN0L2euEJrdEtr7Mk3Wb
 nEh6keBKlrIz65lnKGD+l3QXT0yaouqAp1XCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767827241; x=1768432041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9G6SP3U40zb5U3l9tFkURSgqGmw5CIlxl2TSd2wjWwk=;
 b=KybuO9bY2ZtaAa168hbkd7q/xe1OLvN9oWoDjumIv3cL4vPqexJkSeSUVXrnUWraDN
 Zh+G1jLAu3wSmLN8ChQYuz6dlfaeZdIHKQhppL+3nhSNCIgzy1RDdGjBeDKTnPKmAAdl
 sUNxhHXw2n6tgsZe9sCwmo/IK9/AWFTH3eeBcPwA9CTkRvrDWsSV9PXjkZzSe/QRK4gH
 SGDt6x+zwlJ6GtV60kHDjmIK98XfFkrJ5hxyyhy1pvRFzOzULpVZDj97jo0fwCJKzI1F
 iKi2p7ppQtKLV39maGDQMCqs8PQztzVPLxbgtcMKuQQk3Jla3Y4e2qpHnMsOn7n/y0Wd
 4DjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMXLUGWvhorb6DOOgbecBWT4aZQru4C6HtoUs8r4qjaLFUeLCJArf/eZSHtDJqzDoQ4Sg=@dpdk.org
X-Gm-Message-State: AOJu0YzrSnSX0/jHUn8e6tY67BH2i1IUVZzWI6D/xCtRAQS0hn5rVovc
 32K47+OQRHWTU2ECoUiO9XxnUDuOYl6z4WGdhDNaO3pNpHTfoMltAjt9WLM9Rx1/2SU9W1q84tz
 eeLsgZ/enVi+vgmnXm8Y/3Gm9CazKXn4O5t8qUeimww==
X-Gm-Gg: AY/fxX4lryxTHB+9b3/b3xvX9ueAzvhtOC6PtXZAiTTTc8E1wPN7krDhwKo3UW35SDc
 au1AUZjVAntXyl4ZR8KQ46W6FDxagsiGRLWZD6bkA6K/Fl4zG/Xh8fI7Loz0ThJBikzVWUWEkco
 Jhejjen0nYE7d3U3ISoz+2/k1G5mUhVml+a68nS7YDjIrEcDTG/zdZE7vb3otFuFyc2jY3LXAHn
 L8XGHxw5ZzLEczp2ajOebTsgCZzeOL5dFmW8EaI0K2vY2oqxp0AEo0lXfH0b2yoek4FFRNqyeqt
 Cr+sR2eSdAhohi6UUYcqvrL/ZALH
X-Google-Smtp-Source: AGHT+IHzBC4VOXdzOmNbbCVKBGXjCdpkcLzNIb4GH1YzPpXDy76rzc7LfSdlEKVcddFy486TIJwn2JN8rkzGjrj/lMs=
X-Received: by 2002:a05:7022:6986:b0:11b:65e:f40 with SMTP id
 a92af1059eb24-121f8abb54bmr4278664c88.5.1767827241245; Wed, 07 Jan 2026
 15:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20260105190647.63244-1-abailey@iol.unh.edu>
In-Reply-To: <20260105190647.63244-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 7 Jan 2026 18:05:17 -0500
X-Gm-Features: AQt7F2p_CBbr6ddmtBDZuMKpZY4UM8J3eoAzHd2tHs64mbBn4SbsZUECs3IgVlw
Message-ID: <CAJvnSUBD75MdWmEAtK9+E=ZbE1odTvvxr2fncJ9t=_OrBt9+_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dts: add find float method to text parser
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000bd2e6f0647d45a81"
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

--000000000000bd2e6f0647d45a81
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000bd2e6f0647d45a81
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000bd2e6f0647d45a81--
