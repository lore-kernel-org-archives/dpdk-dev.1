Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73149606A335
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QJUZrDtG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C986440151;
	Tue, 27 Oct 2026 14:49:01 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 6AAF7400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 14:48:59 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3ae0852df46so820876a91.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793108938;
 x=1793713738; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8lryIUzzxpEcCYsEbz4+D4q7D3aabZsT8YyD2Z/B654=;
 b=QJUZrDtG9kvzXE5jguK2wj4RTRV/Tr24w0VKZ2NUGucduB1IOtq8F1rz/Xy8qFP54Z
 b70rb+xZfYDUf5Coy1zoSkkNgcu9jqhUttsZsJJO7iDXgf4HRj4L3MxwlSovNLhJiz4t
 nfMTgpHzGURxAgIBDwxfWqAT7r5FG4ZaJDyHQYbMjL4TIZRNMTJ06MjnwNDYmru9KcLa
 T8SzsBDufutwXXst5HLJGQFYMWQ1/pyWqrv2z+hkNHsrcjVKcoUYbovg1+nwsXD7oSFu
 3EW5qymuvaSzaqo1uq9qcqGpltilGiyCMYfuk28Jv1BzNPGWZnHWvXMwNhnW9pELFQqa
 ur2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108938; x=1793713738;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8lryIUzzxpEcCYsEbz4+D4q7D3aabZsT8YyD2Z/B654=;
 b=ovEKJMaJN54kE4IyAi1XIqIn32kVz6i4Av4D1qJbQez6mR/90GjdSiJtuZi1bm2oZq
 1ASVYOcWrjIV80JVu9XHL6WIRoKf3OfYo+mZlhQwGQlnJoWRAo5KbRJOGbp5iZXEUC63
 lm00xtsUucvdR40c5QQVlNwe/H3rpNE3S9iNHpHyjDxss7jzpj1k5eUJBz9nBqiLhl3C
 SOcZ9mXA27KuVrN51foDOe9zJNthK57sw92noaI+zzU3Z1ZWyi8qvt+sJ88guxENKIyn
 IAcXuUbYhlbZ8VKqhGzxBoCT/Gs0hhYeMV6XES0A885CgBQCfN0HND1cWN3YnfCUdOLE
 OTpg==
X-Gm-Message-State: AFq9FYLXwSkH4rlnSxvSKABUFOt1WvR74hR9eqzjBBzHJejgv8FWU4Xe
 LV52XTtTKxidKS6ooo5or878cBvL60ydjltX2W//suhzAWNh/gKcjeZyXq0M21ysmcs=
X-Gm-Gg: AYBFou1a9sCjY9Vq8JiE7K/B2/MODKTnSVWRVU6t9EzOCnA06om4Bb8TtZbP5dEqSwX
 QDxV0FVL0G4OKggVszEn+ehdSRZtTC8zvWDZqAbPPdFdvnW6os/GF1CWfi8m1FkzCaKZ0ZpgG1r
 S83E9QliqsaekbCFLgIJlk6Z9gz3FvL+pTNx9Xm/bUyp+Jdo9ZsWcIDqbgKiATrX2d3wA8pu18+
 J7WNLp44ngdMZO7ugpLAc5r/si88h3Yt1kKX41XAXZeSVKiYBtR+BYJpJyQ9mAoTaCW38KSBpHz
 d7QLh0B/Vs4HA3+H96BhOd6DKCbeLjiTLKd/B6ACf5ZqkoU9hAHb4I3rU0ACphjzSxj1URR6eco
 dwONlo7qcibjP3hVvcTkqHcyUIZpaib4N4bO0Ihk6lVUgJHisSCCkcDcUcqDeBp4E8pQ/MDtXiW
 +kf24Ko1ASZvl5rvhkDq0NnzL5/kWBLzR+sQStxSPUzL//sltTgLf8jYkoB5DToTNCUwDDfT485
 ll9TJMzAxQK6cPI5RwKQzvGZ9XHVk9ntwxc5JFZ8+pbxoiJYko83Yup1sdHnhk4amnhrch5tIU+
 WBS32JGxl6f19vH+w6P5GA==
X-Received: by 2002:a17:90b:3906:b0:3ac:77a2:18a4 with SMTP id
 98e67ed59e1d1-3ae4017a437mr1744556a91.0.1793108937781; 
 Tue, 27 Oct 2026 06:48:57 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8cc9073c2sm3082933a12.0.2026.10.27.06.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:48:57 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:48:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v12 16/17] net/txgbe: respect manual link-down on
 Amber-Lite
Message-ID: <20261027064855.1b35835a@phoenix.local>
In-Reply-To: <7DFF83FB89E01083+20261027114218.9724-17-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
 <7DFF83FB89E01083+20261027114218.9724-17-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 19:38:32 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> txgbe_dev_set_link_down() clears hw->dev_start, but the Amber-Lite
> AN73 watchdog treats a down link as a recovery condition and can start
> negotiation again. The setup-link alarm handler can likewise configure
> the PHY after a link update or a previous setup retry.
> 
> As a result, a port brought down through rte_eth_dev_set_link_down()
> can link up again without a matching rte_eth_dev_set_link_up() call.
> 
> Use hw->dev_start as the administrative link gate, and skip link
> recovery while the port is administratively down.
> 
> The gate alone is not enough. A setup-link run that started before
> link-down keeps going and rewrites the PMD transmit and receive
> enables, so the port reports down while the peer still sees a signal.
> Stop the AN73 watchdog and the setup-link alarm, wait for a running
> link thread to finish, and only then drop the transmitter.
> 
> Arm the watchdog again on link-up so that monitoring resumes, and
> cancel it first. The alarm list keeps every entry registered for the
> same callback, and each entry re-arms itself, so arming without
> cancelling would leave two watchdog chains running.
> 
> This keeps the link down until rte_eth_dev_set_link_up() explicitly
> re-enables it. The link-up path then restores the required PHY
> configuration.
> 
> Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
> Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

The only valid warning left on AI review of this series is:

Subject: Re: [PATCH v12 00/17] Wangxun fixes and new features

Series applies to main and every commit builds with -Dwerror=true.
v12 addresses the v11 comments on 05, 12, 13, 15 and 16.

Warnings
--------

Patch 16/17 (net/txgbe: respect manual link-down on Amber-Lite)

set_link_down() now stops the link alarm, the AN73 watchdog and the
link thread, but module insertion still brings the link back.
txgbe_dev_detect_sfp() is not cancelled, and on a successful
identify it calls

		txgbe_dev_setup_link_alarm_handler(dev);

which, unlike the _aml variant, does not check hw->dev_start and
calls setup_link() directly. On AML40 the 2 s module poll added in
10/17 keeps running while the port is administratively down, so
plugging in a DAC or QSFP module reprograms the PHY and lights the
link the user turned off. On the 25G MAC the same happens through
the module interrupt, and txgbe_set_link_to_amlite() also re-enables
the GPIO laser there.

Gate it on dev_start, and since set_link_up() then has to configure a
module that arrived while the port was down, run the link setup there
for both MACs:

	} else if (err == 0) {
		hw->mac.setup_sfp(hw);
		PMD_DRV_LOG(INFO, "detected SFP+: %d", hw->phy.sfp_type);
		if (hw->dev_start)
			txgbe_dev_setup_link_alarm_handler(dev);

and in txgbe_dev_set_link_up():

-		if (hw->mac.type == txgbe_mac_aml40) {
+		if (hw->mac.type == txgbe_mac_aml ||
+		    hw->mac.type == txgbe_mac_aml40) {

Review-Result: WARNING
