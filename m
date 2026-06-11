Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE363CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 18:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 961E3433A3;
	Thu, 11 Jun 2026 20:54:26 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id C196B4025F
 for <dev@dpdk.org>; Thu, 11 Jun 2026 20:54:25 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso555674eec.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781204065;
 x=1781808865; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYb9s3lRc2nDbEdD8/0gIc0RZT2h2HHY2NB1jAbDtCU=;
 b=Gw5rSMjgEbiPOchLvPc3zyF8QztgxjCgoMCarwd35EDN613/MEiUdqzjohpDvqifXm
 18HxYZTaO967K5+qZqfSuQgoRzRc0OSzsYFWusHCYsqZOrtAOK90s345Whu9Mt1Tjtz6
 FRme9fVoDtjm+ssPC6+4MEP+PzG78rQpaggdB8VGJc6I3eYG5yRxrKuFr3YepGUn1C+P
 pV9jyDmR1FSna38bCkJbxNNAYBlo/stV2OEwFhYYL/aMwB4cNkRV/wnJD2MBuFijSxz9
 E7esm/Rqcj+C7oOsnb02Fu2f9WYDRhspE0TVdFs4jSzKJUvUpQXRsbDRdGmw3TFVrCXV
 7r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781204065; x=1781808865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oYb9s3lRc2nDbEdD8/0gIc0RZT2h2HHY2NB1jAbDtCU=;
 b=olV1XUY+9Y++YKRZ+D2f2Vzpwf+gAoRhy/uq7rfu+022TsnkBmZ4K3rFd2v6WM++h+
 sowSC0l3hfky8pQIpwK24g/LXR+kI4nYCjSRJ6Qu4rB1K9DHsbYXljhktc2VZFal6Ihm
 aMRqZS7U49av6gNossrcV4435pEMZqdV44YOEfKHH8ldckq4BTuDPwNT3T67r+EpVvdC
 g8fOYYFzSB1mX8lgINYzQsKaqEuRki6jH+Z3ldKbVD5zn04Zveg0Z9q6DTuAy4xwh8aq
 7RdnlDFCZvuMuj5oQV8L0mmjkXe9EUfLoTFnfORcOdYJV2cOQaSuFx3wFLHK/QDlkwL2
 1HKA==
X-Gm-Message-State: AOJu0Yz7Q/hrcWeQ5n+d8rHWrfElspgFKSigTcwx3Vxj9/sKnyA9x8j2
 Gp6ef8brKbwtmFufJJRns4qJH73M1nxs5332Hj4MT9ACFMkehUPYnjheWNflkynyxc0=
X-Gm-Gg: Acq92OGF5XJcLccDEfPdTkyGQfV41vFhrUlJk3n+S13tFwppJsYObUExm51Ck0Qnl/2
 dIyuVuZAUx91WXl5iULrF4UTlLqqWwOPR8y/LXjaOXfxq2Yu0E5Coz1lr/RDhjFdr7SJDGRillQ
 cfoJiFnwn4+I1UhV5ziPtGS4f6Ynv8wQpDfUaHMTyWiWATObtBgoGk+Pn1obwLsJcVAHCLeNZgX
 Xzagv3hI+myVh+5ot6xfiGwCKjISt3tPNHb81IfTlbaN4WxZBkLJ/4cseixk5WnfIMBxRkcUUH5
 pON9sDuD7nfwxrmg5u5Sj9jqF6fCkCEMnL5FIrDfeEX84OcM/Zc109Jnk8mAPLst/sVHphi9wnF
 c5x0gPLydqTjH7vEZU8du23r++hKfNMh/Q7IjPzL45EqvSbzC9vzTZqV3v9yCP0HerGMLj+QISf
 8mcTAV78b1DJGdnjaNa7sEnzoU7lqVRiutscaikwlRwS77lmBqJ7ZNnMdVlBAtYTLl
X-Received: by 2002:a05:7300:542:b0:2ee:ade0:e0bf with SMTP id
 5a478bee46e88-30804b96826mr3154970eec.30.1781204064559; 
 Thu, 11 Jun 2026 11:54:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a9f3sm3106442eec.18.2026.06.11.11.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:54:24 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:54:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb
 <patrickrobb1997@gmail.com>
Subject: Re: [PATCH] dts: avoid Scapy MAC resolution in Rx split test
Message-ID: <20260611115421.12c4e6ee@phoenix.local>
In-Reply-To: <20260610183218.751941-1-thomas@monjalon.net>
References: <20260610183218.751941-1-thomas@monjalon.net>
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

On Wed, 10 Jun 2026 20:32:18 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> The test gets the Ethernet header length from Scapy with len(Ether()).
> 
> When building DTS API documentation, Sphinx imports the test module
> and shows this warning:
> WARNING: MAC address to reach destination not found. Using broadcast.
> 
> Use a dummy MAC address so Scapy no longer performs
> destination resolution during import.
> 
> Fixes: 01c70544cffd ("dts: add selective Rx tests")
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Thanks, I previously reported this as:

https://bugs.dpdk.org/show_bug.cgi?id=1951

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
