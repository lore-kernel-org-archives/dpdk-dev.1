Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D484606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=Nen9h2LJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60E7F402A3;
	Mon, 26 Oct 2026 12:08:50 +0100 (CET)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTPS id E465240150;
 Mon, 26 Oct 2026 10:29:46 +0100 (CET)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1793006983; h=from:subject:to:date:message-id;
 bh=shqIh0Nf59uXoDfXxpRpfqJx03B4kGr1floVDfdjhdk=;
 b=Nen9h2LJh/A0OH8QGZ5Ml5cKU/hZY0NUEicO/SycZm2jsQltBZVRF1Ic/alzunMXIyB7aLxJ+eh
 itJoN88DL+5yOAozR1kHeOQFQbn4zkSkbLFufpq3+A5VzYy5QTsgQclOspPK+EN0QpzYoN9k4EEXR
 hl7WWA0FbEv8RVOVDqtoLGUP01Is9eiKX+7zegaTfRowFkXvUAObiryPLTLh7UElfWCaepEDb2HYk
 YF708YuLvu2EZDt3m6F+TNZ3mZFT2HPCzwPN20FFp76mRLmGoyDLUIb3TaOh/nsem0vWMpMxTZ9/G
 +QxzJzu3U54NCFuCkhozaN1GaRcHHNJh6w2g==
Received: from dish.amicon.lan (172.16.30.10) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 26 Oct
 2026 12:29:43 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: <dish@amicon.ru>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <dmitry.kozliuk@gmail.com>,
 <rrv@amicon.ru>, <sdl.dpdk@linuxtesting.org>, <stable@dpdk.org>
Subject: [PATCH v2] fbarray: check file lock downgrade failure
Date: Mon, 26 Oct 2026 12:33:20 +0300
Message-ID: <20261026093320.858280-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928150025.593474-1-dish@amicon.ru>
References: <20260928150025.593474-1-dish@amicon.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Mon, 26 Oct 2026 12:08:49 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello!
Just a gentle ping regarding the patch. Is there anything I can do to
help move its review along?

Best regards,
Daniil
