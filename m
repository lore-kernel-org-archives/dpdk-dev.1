Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231B606A882
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rc8fCRk+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7B744026F;
	Tue, 17 Nov 2026 00:00:35 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mails.dpdk.org (Postfix) with ESMTPS id E86F140150
 for <dev@dpdk.org>; Tue, 17 Nov 2026 00:00:33 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso13817565e9.3
 for <dev@dpdk.org>; Mon, 16 Nov 2026 15:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794870033; x=1795474833; darn=dpdk.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NXYGgWVOPSWMZk34eAsFQPlprSdMMwIzUxDibp3wgo8=;
 b=Rc8fCRk+Ds53UfY6UvvoGtpjoYU6DNiE05Fi6kORITqWN13XATDOS8Ay8iVLZTZZV0
 q9l7gQKK39lRSdaRTue28/fX1LtWg4fcDRRWc24NI4MgSyE9o02DxnhVw6fHp5IjXIqp
 tjm6lIdI8DjRNX5NdUFe64ObuX71moNEkzh2pJcPFFnMBNeS50o3yHsrG93bdyM2pLDw
 YDV4oYU0X/D1Dh6TlhCgwPjYtasj9GttCPTs1oUk4KEPQ+3vfjqbdguSCrLDnj+LZFTz
 B0Nj6B0kjJ0Or6+nCBxhM4lh9qsQvS3Eet8cCj1gwYTkGHAZ5vJsktZolq/v7cpPBZoj
 XgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794870033; x=1795474833;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NXYGgWVOPSWMZk34eAsFQPlprSdMMwIzUxDibp3wgo8=;
 b=BC5GqMHcHv3iwKHvHM+o1Gk+4fp6DoDtKcR1L7IP7mqAmhbG5Iy6ajbPNe0AR5R/aJ
 HgRKO2oH7SK4c9uo0FdHt2upKAq34Lb6PCLkeeDgvwnbrcnOHDBGz+bYrv/5YVVGiqSK
 HR0LxH1SPtrR22oF7rTI0eIHHEYI5yCsm2a9i24EHc6ydSucgS4iujXIDTWNcu+XsPqw
 xxJkIIcnqDm9AgsVDcf7yHS4Q1man27mU9/nT+vxxhL5cIJW/nI4Lmu4hzxlmhW8fJ+Q
 tVP25PVmlrLSUig9GmTfCipSSZHYrQNud1OePcCPyTDSmstALYcMO5OiexMZvL8sjENQ
 Kk2A==
X-Gm-Message-State: APuU4Z/IMqffl5+ul5ERe3U5CtnLTf7r6b6XkFjnd5lgcrfpstY+tSXD
 5kiNo3BqZ2FzP0SWFH1TonirHDeSUBhljw9d0OY6z4XZ4VfZ0I9xWrzf
X-Gm-Gg: AYBFou0sOUF3x+v9OHbMPXG6iaghjU9VbEm/7AZTBjD1i4HoOnXY/BnXtDC5r9CluWQ
 z5gQaUaw+omb23NdX0Xn2n9w6xpR/RgS4GQyu8zG/um9CD9vxCdtyfZD7MZUutRnGim4jC+Qp9V
 1bP2nvT+bhIEox3zk1y+8CYUxYMKpJY57XG1Puj0++p0/ktIjvEXf1IFrL0LE3v0gbLkSNOtECs
 /5TQo/FprJU9UnF0Veuy6FkJnDNPt7/S5zGDKlsN+sLG1+waqa9VafS2em9e9opxbZ7jASbu71H
 KWTHhqoQtv+yHm198oThXMfsu89nfOl0+VQ1QnW3qJ0kmcVsZrEZsH5cCS3TKQ/h57TXEJQsHRm
 cUSTi9418BuUA32qjuF7tvprnRMcG2fC8KxlbyDTtcPG97UD4TQLIu/bxwn5ZaLxQVfQsuA2IMl
 Ek/8z6b1jwGBkc/x7iA86m1cXRlDovlxDY/ESniwhUL8/P0JGNQVKTSkcWOd6qdvvK13uXtagR8
 ETBxeu+qlaF1QItO6kCuKzBdV0tnaoQV1+0FwA2PPL5jikpBLw5LjXJ9ajMMO33AGjYopVhfUPv
 42D7zlodRTBUopeLDt8ZNpbYv6KdPah1KQ==
X-Received: by 2002:a05:600c:1c0e:b0:4bb:68e5:b952 with SMTP id
 5b1f17b1804b1-4bb68e5bb4amr177952725e9.16.1794870033415; 
 Mon, 16 Nov 2026 15:00:33 -0800 (PST)
Received: from localhost ([2a01:4b00:d036:ae00:2aa5:bf13:cd58:a0d9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb783965c8sm20147045e9.9.2026.11.16.15.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:00:32 -0800 (PST)
From: luca.boccassi@gmail.com
To: dpdk stable <stable@dpdk.org>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Anurag Mandal <anurag.mandal@intel.com>, Bing Zhao <bingz@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Kevin Bowling <kevin.bowling@kev009.com>, Matan Azrad <matan@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Soumyadeep Hore <soumyadeep.hore@intel.com>,
 Suanming Mou <suanmingm@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: please help backporting some patches to stable release 24.11.9
Date: Mon, 16 Nov 2026 23:00:23 +0000
Message-ID: <20261116230026.947406-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Reply-To: dpdk stable <stable@dpdk.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixes.sh
I didn't apply following commits from DPDK main to 24.11
stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 2026/11/23.

You can find the a temporary work-in-progress branch of the coming 24.11.9
release at:
    https://github.com/bluca/dpdk-stable
It is recommended to backport on top of that to minimize further conflicts or
misunderstandings.

Some notes on stable backports:

A backport should contain a reference to the DPDK main branch commit
in it's commit message in the following fashion:
    [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]

For example:
    https://git.dpdk.org/dpdk-stable/commit/?h=18.11&id=d90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb

When sending the backported patch, please indicate the target branch in the
subject line, as we have multiple branches, for example:
    [PATCH 24.11] foo/bar: fix baz

With git format-patch, this can be achieved by appending the parameter:
    --subject-prefix='PATCH 24.11'

Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".

FYI, branch 24.11 is located at tree:
   https://git.dpdk.org/dpdk-stable

Thanks.

Luca Boccassi

---
5e45dcdf1e  Anatoly Burakov  net/iavf: allow flow validation without engine callback
7810fe8de3  Bing Zhao        net/mlx5/hws: fix eCPRI flow matching in strict mode
485360e1e8  Ciara Loftus     net/iavf: fix crash in Tx drain on PF reset
36f9648dde  Kevin Bowling    net/iavf: fix AdminQ polling after interrupt setup failure
