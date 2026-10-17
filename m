Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8550BCCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 21:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E16440276;
	Sat, 17 Oct 2026 23:17:29 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2473540276
 for <dev@dpdk.org>; Sat, 17 Oct 2026 23:17:28 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso4534525ad.0
 for <dev@dpdk.org>; Sat, 17 Oct 2026 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792271847;
 x=1792876647; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=piRMKV7Uj0ZlMGBkzEG8dYoKK1LmR+Xk9PEwuhar/0A=;
 b=FtZ51Wy08Uv5fec7oToxX21TS886kqdp86vx6zUbI3gDDW7HDbjfg5Z15Fw8UZ3HM9
 o01kPhM9bxBdURe+RrlqO3cuTAYDpx4Hj/H9C5CHV5HQOtO20s65Qj4nLUIjWuogg0Im
 4gElBKBgJeaK458e17l3+6bi/gdA7f5/RjGJf2pJONr55KgtgfwiB/BQX/IMR6mi6+/c
 7itVI4CBjBYMI47ikvyeZdH6T9xQXpV6Q0Uw3WG9bHPXPoQUG7T7uplweaEOWLQXHMez
 4Zy3RctkQk31xGlkjY9zIRxCxMoLvql+dyYolizlYTmHTJDIV1uV03+WxZQBrLjIxEh8
 Nh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792271847; x=1792876647;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=piRMKV7Uj0ZlMGBkzEG8dYoKK1LmR+Xk9PEwuhar/0A=;
 b=fYZdSRZoAxoFctnq4gYDfoQFYAu6wAdAmNUXcM4DprnIigRM/h2POb3bKpdIv/qgbG
 EoY7Y+BtnsjH5n4ktlU8bCIRRrpocX8WS2YDtyIXV9tEdVIFHvx4aElAkBDN+BV4Zr1W
 3IR1WU/SX25akHj5H1X0cg7TeNRuG1PBSGEVVF5jWjV2Kv4gATQ1du51S6YcwkILiOp2
 A9kftqXWEhWVVT2B7uzo6H7fnV2jVskXr6nRlLpXO21K8YWM+ITEmcal8EPxm32GYI/W
 bEWwYOJUnMIRqdRUSNizYxfEOeBStsSrq5pOt9QFwo2adhTqVea0l2sNjQGyBixunQY0
 rzuQ==
X-Gm-Message-State: AFq9FYJNVV+w3xHJFpfrzdBk+wVwTmC1uo9n3QwpZ9jbPJYHJjJkNjDL
 d3aDA+Djv1vTvSfuCTjwe0Ya3+WzwBg6RdqO9Flx6u0IDuIuYyQzyejl1be153UVAC8=
X-Gm-Gg: AYBFou2wRiIaoo0DPpf0xA89bXUDhliXl56qoBu7gDFdFxterKaaVSc+W6lZ+RVoQaD
 zTN2M/7bV0SaFMgXQuSbmkgoplu34LwcB2djJ/L32U/0kNZrV0VwvQItqDuTSPrBX+9pVzManKG
 mZtukuBAdLxrYeEHmJpDr7TJhKlKbxDxr87IEZv1rhrwkN90Axxjujjcdx3F+/bq8c/EnE3cA79
 xHsk4NqZXzxVTkmRhMaYVfNpwOAjB1CV23kMwasy3jA6WA4dLgXdzlYg4MyAb4JEqZUuxZ/W+PD
 4hDdrSVrvpGqCWbO/RfQrGUWTd7SR7J4btVQ4Hv+HTVv1CvMjCaASsfWBUCDptPclbBvh1+zhh/
 OT3LQ4mZI7XeehNOlrwfD1dQEyufjLLaV+I8sVHWtKzvy+s8t3RIujXWq2PwfKT/jES1SUtxryJ
 eT0E8n5FEnt24aQ82Vz7U7mFc19Gh/Tqos2bvsTrWJ7g/G/CiRHtWVDtIgQoHqHssWjJB5sJBi2
 KUeK+dJn5DRTbyM4fr2Qk2MI02a1ztudmUMt+9r
X-Received: by 2002:a17:90b:4a91:b0:3a7:db88:3491 with SMTP id
 98e67ed59e1d1-3acef4e02b1mr3226077a91.33.1792271847006; 
 Sat, 17 Oct 2026 14:17:27 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549b761bsm2479694a12.15.2026.10.17.14.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 14:17:26 -0700 (PDT)
Date: Sat, 17 Oct 2026 14:17:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>, <stable@dpdk.org>
Subject: Re: [PATCH v4 0/9] net/memif: lifecycle fixes and unit test
Message-ID: <20261017141724.3723038b@phoenix.local>
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
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

On Fri, 16 Oct 2026 21:58:48 +0200
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> This series fixes a set of error-path and lifecycle bugs in the memif
> PMD and adds a unit test for the driver.
> 
> The first eight patches are fixes:
> 
>  - guard eth_memif_tx() against an empty burst (nb_pkts == 0);
>  - close file descriptor 0 instead of leaking it;
>  - do not close the EAL-owned memseg fd in zero-copy mode;
>  - free the MAC address allocated during probe on failure;
>  - unwind a partially-created device on create failure;
>  - refuse connections on a stopped server so it does not come up on a
>    stopped port;
>  - disconnect on close so a stopped server's control channel is not
>    leaked, and make memif_disconnect() safe on a never-started device;
>  - fix eth_memif_tx_zc() returning 65535 on an invalid interrupt fd.
> 
> The last patch adds a memif PMD unit test (app/test, memif_pmd_autotest):
> a server/client vdev pair over a loopback socket covering dev_info, link
> state, stats, single-segment loopback (slow and fast path), multi-segment
> loopback across a ring wrap, stop/start reconnect, empty Tx burst, close
> without stop, and a stopped server refusing a peer.
> 
> Verified: memif_pmd_autotest passes 11/11 (~1.4s); devtools/test-memif.sh
> two-process forwarding OK; each commit builds with -Dwerror=true;
> check-git-log and checkpatch are clean.
> 
> Thanks to Stephen Hemminger and the ai-code-review bot for the reviews
> that shaped this series.

Applied to next-net.
