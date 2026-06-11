Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B2CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:30:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BD7442F7B;
	Thu, 11 Jun 2026 11:30:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 08F4842F75
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781170217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fEZuUuoJIXTu5ywpvRAQ+3+G0ZwRWHhYAILI1/KwwSU=;
 b=FIahK2iKdWZTYGr3I0lazKnM+154syk/kYDtVKMJEF8d2P332LTfbssKZpvJViuXxFsYFw
 +acLeA79/ZP4lfCCHoWJ9Fubvo8sdVKeoGhSaMYTZSzjvGckaqtnFKuM1DW1itkbs10RaR
 1CzbPHkY3+vdyJnFLFZ+Uy7wVxvuge0=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-aiPf6Do6PpSrrCfASBX7lA-1; Thu, 11 Jun 2026 05:30:16 -0400
X-MC-Unique: aiPf6Do6PpSrrCfASBX7lA-1
X-Mimecast-MFC-AGG-ID: aiPf6Do6PpSrrCfASBX7lA_1781170215
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3080bb0267dso278274eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 02:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781170214; x=1781775014;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEZuUuoJIXTu5ywpvRAQ+3+G0ZwRWHhYAILI1/KwwSU=;
 b=k+n8NObVEHbKGNyKiA1QkdV5yN+seaixjGv/wbyE783VzV9hbW3Tagj0DpttS/ECro
 RqDQDtkiDfIyRR2XgMfDnLY/vPFNLiTrixFUvMEUF15fWEwk0fc4aZz9vDqACQoTf3my
 uw5ZXcs4lchooh9OwQcbBSOt3fXkI6TZnFRztMv0eo7Yni9I6SJ+IWMkPUBoyg+Bt5ml
 /dZq5IGooPJ7M4PPoeFm2RnRTrC5Nzw5pzWisKKkvoMZNxTOE1kfmZbQ/w5gslfIPxH9
 AWqaodr1+uZZXuWxhIsSt9u9rplrLKu/YNyXV5eUlYgLUzc/fk25txhLoU4ZQ62FN0Jo
 uolA==
X-Gm-Message-State: AOJu0YxdcFWzmLp3/zGziIVI8Tl6osfxJZI+LmaeUue+s8RA5FyL/jIw
 cQex2jWGH5Bes72RO7JQMFJVsE8ap4jqlRVJlskF6MRDLdnThasBQAZpJPdkFCq2eU7/5b9tvRM
 286jLRtae1aM0y7D70AC9jGNW2+26CS11ieU2C4eBRyhl62nh9W8Ddz54tsM8vz4e8Sb5SiPZlZ
 Y4+pIjOeafmhv54YqWvxs7jO6pIOwNoQ==
X-Gm-Gg: Acq92OFWwfdKZiuvgMn5aL+ibziDcOgdpZAzCvXuUwWthkshXRzU8bB0D8TBrmrsG/C
 kStgAzxRwLm1Y19RT/kPW6YV+Kefd57QyGgtf2y5IEQDrz+LWYxlscUdKSmzi87G8LTswqVvH9O
 nXj4XYY3gx/JHv8XI1Gbuyawr+2X1SzhmJiMFacakOSXLTeB6wazZ+jXZ6rDvQ/kd7jW72ryMIL
 H3TgLxAertZRP9rtxaE1Pj7ic4wFA9VbS/7R/PnHwAoQKySb1NgtKOcAuNMYQh7Ooyshb8Qh0W7
X-Received: by 2002:a05:7022:2383:b0:137:567:14c4 with SMTP id
 a92af1059eb24-138421d1998mr1153835c88.29.1781170214466; 
 Thu, 11 Jun 2026 02:30:14 -0700 (PDT)
X-Received: by 2002:a05:7022:2383:b0:137:567:14c4 with SMTP id
 a92af1059eb24-138421d1998mr1153818c88.29.1781170213920; Thu, 11 Jun 2026
 02:30:13 -0700 (PDT)
MIME-Version: 1.0
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 11 Jun 2026 11:30:01 +0200
X-Gm-Features: AVVi8CcmcB1JwQttvTNFfNJ-pOXhX1xWTMmoxeOZuLEuzpLhn-t1mP3OZ1a5S4E
Message-ID: <CAO55csz03U8zwNudQjhz6H1pdtEGuS2j5OBQw5sXUcNXe7nCfw@mail.gmail.com>
Subject: Technical board meeting minutes for June 10th 2026
To: dev <dev@dpdk.org>, DPDK Techboard <techboard@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jr3JcWCB1MgpoB1DFvlQmvDMNRqYcgk-uVWKMZ_se5Y_1781170215
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Attendees:
=3D=3D=3D=3D=3D=3D=3D=3D
Maxime Coquelin (Chair)
Thomas Monjalon
Bruce Richardson
Stephen Hemminger
Konstantin Ananyev
Aaron Conole
Jerin Jacob
Hemant Agrawal
Morten Br=C3=B8rup

Topics:
=3D=3D=3D=3D=3D=3D
* Security reports (Thomas)
 - Discussion on the CVE filing process using Red Hat as CNA.
 - Maxime will file CVEs for vhost-related vulnerabilities.
 - Need to identify who handles CVEs for other components (e.g., crypto).
 - 10 security reports on Marvell drivers; 5-6 already fixed as bugs.
   * Jerin to follow up with Akhil to reply to reporters.
   * Discussion on distinguishing bugs vs. security vulnerabilities.
 - AI-generated security reports are becoming common.
   * Aaron suggested treating AI-detected issues as public since
anyone can run AI tools.
   * Stephen noted duplicate reports for already-fixed issues.
 - Vote: Create a Slack channel for security coordination.
   * Members: Techboard members, release maintainers, and component
maintainers as needed.
   * Vote passed.
   * Next Step: Thomas will create the Slack channel.

* Loongarch Lab (Thomas)
 - Lab was producing systematic failures and erratic results.
 - Thomas disabled access to test-report mailing list (reports now in
moderation queue).
 - Next Step: Aaron will raise the issue at the DPDK CI meeting to
coordinate with Loongson.

* New PTP example (Thomas)
 - Thomas merged a PTP relay example (ptp_tap_relay_software) without
prior Techboard approval.
 - Concern about naming inconsistency with existing PTP client example.
 - Stephen will review the example and consider renaming for consistency.

* Release update (Thomas)
 - BPF patches from Marat Khalili have compilation failures when
applying patch-by-patch.
   * Marat will fix the bisect issue.
 - Ring library patches from Stephen also have compilation failures;
Thomas will send details.
 - Power library patches still to be reviewed for RC1.

