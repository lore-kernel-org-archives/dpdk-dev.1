Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F30AC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:18:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2F8A42EB1;
	Fri, 16 Jan 2026 21:17:58 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id 1D48042EAB
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:17:56 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b872cf905d3so406417466b.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594676;
 x=1769199476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPu+nT4GvpteYVxvx7M/IGbRLXo2boyffp123qBFOLc=;
 b=PVpaiG0XdVMwdf4pwLYuM1e0pcGpivGQDy32U13nr9lBr+FHp3FaSvPHVNgyyieSdl
 rcqlT6GtKph+oqvG2ktzJbGDhA1tt85gicz4XeHKwxxzbvOfcumIjZiBfDKIVOpr3XZ7
 +eqFdrMlPSfdezbvrZUD4cRsTBUQejtUWXcgClZpvS4N7leF8h3kn1pVsW+lumFu5ma4
 GrWrNeG8TEJ6dD3bgJ8KaX6ZhKD1oDDh5zEBWxkABWRhBCGDpX6tgdlTpDT57RQKJF06
 sy/NeDEfr70Sm8lUF84N+xYby8IMLQxHlVj1PqerXdf+18sP4tugsqsWOLWDQHSbEXgi
 a+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594676; x=1769199476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vPu+nT4GvpteYVxvx7M/IGbRLXo2boyffp123qBFOLc=;
 b=n1JtkLgJ7kS5hGPZojIJvuh8wjr39f9alsN2UsBJAcX0gH7xgpw4V6OBewse6bp1KB
 9Vhlv/eNmZJYHklqEytlbI9VsWRYFZX4p9GyJsjrsRSoDR3fmoml2fNYt6z6k6wc9sP2
 QFvNA2rAaOSQ3P+k18YE3/QOGaWTO1cY7hMZNCfpyfjUnaCaoC7CX9GsjRc3DvEn/290
 zCE09CINiOOK+0jtLfdNkPRvXbYrPsZDKYBjPOmxUs+6En+ZUtPTpLLzbofHJX5oTuuU
 GeGVPEZ5LyJsbFuqlsgzwTAwGXqRbxav8k2KsTzuOpjoPA8ocPkYq3THYaUR9O7jr5sf
 nwew==
X-Gm-Message-State: AOJu0YyjeX7M1IxY4xEkGtF9LzzA+4oemAZ3oyCLCL2BJNdq+sG6Vfgn
 tZ5vUhPv5JaG16c0FWdFWX4LNUhWSyefaDUrkdSK8z1Ed8BtMUMHf7TfomlxaWa2KGatmByrxll
 HAzF3
X-Gm-Gg: AY/fxX6SAii0eWOtGJCHxLfQFm0Ra8bEhptdpRMpo73AVSJO5yAE41Q4atGjRtM7K6b
 zdw+/lbX+ywayl4YJSPK1H8d7LmsSNlS/byJGL6kP9ohrjB6J9YtF2rx9CjwHSvIssUvx8Zpykj
 UVirFloEBF0c96H/+bfbZUUq2PogOJy7NVYKqC4gR+dTztuJC2SAUnF8f41Uj/2obezYYVfu77X
 a86JAYPVyNYDFVFzBq62X0ulSwL+dcb7pFq/t6YMNDOxVCCwkiHPzbPruKOpy5A692nFuptGZbF
 sIyVyIJ4GBPPahj59jk/aiwZ+7UZFhz5/fHcOa6T/EbjE/S+KogJCMRr8DijLlC+j1ek8yMbyLZ
 8NnTFyfoevhiM+n9zP/TZm5fwVUB3RlIZeB/8ArLpxK6TLcOvtES5vBS6O+DLaZQTuGDurtB7z6
 hDXOhiJCtxxMu6exO3C6FqzKLo5yS9ANYOvkomLP00hTrwBwsOaw==
X-Received: by 2002:a17:907:9496:b0:b87:17df:4d65 with SMTP id
 a640c23a62f3a-b8796b83e53mr308116966b.51.1768594675261; 
 Fri, 16 Jan 2026 12:17:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:17:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 07/12] doc: improve new library guide style
Date: Fri, 16 Jan 2026 12:14:25 -0800
Message-ID: <20260116201738.74578-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Improve the new library contribution guide
- Converting passive voice to active voice
- Simplifying sentence structure
- Using more direct language

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/new_library.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/guides/contributing/new_library.rst b/doc/guides/contributing/new_library.rst
index 99890beb29..25237b349f 100644
--- a/doc/guides/contributing/new_library.rst
+++ b/doc/guides/contributing/new_library.rst
@@ -10,15 +10,15 @@ Process for approval in principle
 Rationale
 ~~~~~~~~~
 
-Adding a new library to DPDK with proper RFC and then full patch-sets is a significant work.
-In order to save effort, developers should get an early approval in principle,
-or an early feedback in case the library is not suitable for various reasons.
+Adding a new library to DPDK with proper RFC and then full patch-sets requires significant effort.
+To save effort, developers should seek early approval in principle,
+or early feedback if the library is unsuitable for various reasons.
 
 Process
 ~~~~~~~
 
-#. When a contributor would like to add a new library to DPDK code base,
-   the contributor must send the following items to DPDK mailing list
+#. When a contributor would like to add a new library to the DPDK code base,
+   the contributor must send the following items to the DPDK mailing list
    for Technical Board approval-in-principle.
 
    * Purpose of the library.
@@ -38,13 +38,13 @@ Process
 
    * Any new library dependencies to DPDK.
 
-#. Technical Board to schedule discussion on this in upcoming Technical Board meeting
-   along with author.
+#. Technical Board schedules discussion on this in an upcoming Technical Board meeting
+   along with the author.
    Based on the Technical Board schedule and/or author availability,
    Technical Board may need a maximum of **five** Technical Board meeting slots.
 
 #. Based on mailing list and Technical Board meeting discussions,
-   Technical Board to vote and share the decision in the mailing list.
+   Technical Board votes and shares the decision on the mailing list.
    The decision outcome can be any of the following:
 
    * Approved in principle
@@ -53,5 +53,5 @@ Process
 
 #. Once the Technical Board approves the library in principle,
    it is safe to start working on the implementation.
-   However, the patches will need to meet the usual quality criteria
-   in order to be effectively accepted.
+   However, the patches must meet the usual quality criteria
+   to be effectively accepted.
-- 
2.51.0

