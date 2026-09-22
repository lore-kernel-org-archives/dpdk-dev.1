Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950EFC98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:42:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF3BD42ED0;
	Tue, 22 Sep 2026 21:41:53 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id B399B42EC0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:49 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd78e6eso98581a91.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790106109;
 x=1790710909; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RORgoZPiX5+No0cqwP+xEKpmzMhzbpv8Z3kCQt9nWGQ=;
 b=fhPvDT6/IttlkAcubGLURWBiHi7ouWGig0Mo3tKd0NIbBI/oY8V8ZBhvl9HpbJjD7z
 hAWVecqLonPXNx/JbbWfG6yy+KYzx2cwDvVYJBD6/R5fYQcMOv6GuGG2XZyGkw88kDq1
 MqDAHrdDhXIpVOmP5k+ZufAmgFDcMJunh1E9gK1zBhVqrW7dse9NZxpeftAiYSY/zB4G
 Ei9UI+90Pfp85AvU+TnMPJpUgYP/KzUgWDLjqd/JpzMz9k5QS5ysQ7ZStXZ8plU7Zpsu
 6Sa5n6zho0h0hk8ozLerwyTQIJf1fZAwc0QOqn8zESO54ZfQNCYuRiGuHEuuMNADuj8Q
 XTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790106109; x=1790710909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RORgoZPiX5+No0cqwP+xEKpmzMhzbpv8Z3kCQt9nWGQ=;
 b=nRl11FJHQlMOuYWsnTomtJkXT36nrTrmu10hktOdaQnb6utmgZi16y1EZNYkb2YYiy
 zPtNb52rtDG4p+rNQ3T3HYXN7pdOQHpXxHTkyhXem03G9m2JnZ7ER9ouefb7Jm4/jLOD
 H451hxlV0OiQpC8JDbxq93oYD3kpADLA+zV4iViwWLfD6WSHCKWwvIX4fZDluJ/qNdQM
 NfCcpE0e/RIRwnyLbDlXzYSmFrH6TqYgg1cH5Z9oD00+quMxtnk81nuVgZWNdvmRNqFI
 MFzXRMy7qaw07ycXhIgeyFM/pIIctAQenm/2z9ye07u2Nrybb/auBqASY63l9put4syP
 8ZFw==
X-Gm-Message-State: AFuF++lNnvb4fuIVq9LjrsIKbTN+siqNZYtjocz07WyZEsznD3wnItQO
 II0QZIFkBT0KkrmuJrxAwiXshtwUgQslF5uhw1Vy9uvufKperFKgRCoOo5RCKaFYt7fTZrUkt5z
 bqKnc
X-Gm-Gg: AYBFou2Xd15qAkMuZgSGg9Xe3Gh2UY2wFpJo27I9OV7Qb0afL31pLDBy2mSSPP0GIFz
 wyVrub6ny7UzLK+qVB4PvkCYxm9WXhLWrrQUahg8ri6p0hPO7z0nVW62bE+Ecz4OvzCIyImW2o/
 /jSMLLvZnK+TET7Uhve+XiTYCvfeGhDONiOosLI8qlokwwWqG8MiG+O4aB/vumCo0i0fLDG1ANd
 EHmQFjWVTLGwfBdT9GerTavqQVs5TfTn4u9/J2eHp9R2mJ7TQkhIx86xLrjWvPABhQv/qA8AL4A
 s9Xt4kqrVe5DI/d7tSPsNgR65oXFwI7LTrzFe5qrUWWwZlAjHFOKmIjRb91RI8biSA3E3PesIqK
 5tfzbtKQJ81w4L2QXNSaO+0RWJdFG1O5zVR4OYfV4fEOJyfNOwTworvwCJcIWYDxB95nQUPmjbt
 2ZeQ7NHNolIRRuYmgkW4LC8oQU4e+GQ0qZKTdXnqD8c098L1n9Fj+RiMgHWF1SRVN66TxYEVFUZ
 9LHn52oUk0BukzCEZYcNWxO/NpEUQMw0I5TPQ==
X-Received: by 2002:a17:90b:3bc5:b0:39e:4c7e:bc6 with SMTP id
 98e67ed59e1d1-3a07e595acemr263628a91.20.1790106108638; 
 Tue, 22 Sep 2026 12:41:48 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf1cf3sm814881a91.9.2026.09.22.12.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:41:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH 7/7] doc: clarify memif secret is not access control
Date: Tue, 22 Sep 2026 12:40:58 -0700
Message-ID: <20260922194138.508919-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194138.508919-1-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
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

The secret option was described as a security option, which invites
using it as one. It is sent in cleartext in the connection request,
and when passed as a device argument it is visible to other local
users in the process arguments.

Describe it as what it is, a check against connecting mismatched
interfaces, and document what actually restricts access to an
interface. By default the control socket is in the abstract
namespace and has no filesystem entry to own or permission. Only
with socket-abstract=no do file permissions and the owner-uid and
owner-gid options apply.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Tested-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 doc/guides/nics/memif.rst | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/memif.rst b/doc/guides/nics/memif.rst
index f8b629ab1f..5552d319d0 100644
--- a/doc/guides/nics/memif.rst
+++ b/doc/guides/nics/memif.rst
@@ -47,9 +47,27 @@ client.
    "owner-uid=1000", "Set socket listener owner uid. Only relevant to server with socket-abstract=no", "unchanged", "uid_t"
    "owner-gid=1000", "Set socket listener owner gid. Only relevant to server with socket-abstract=no", "unchanged", "gid_t"
    "mac=01:23:45:ab:cd:ef", "Mac address", "01:ab:23:cd:45:ef", ""
-   "secret=abc123", "Secret is an optional security option, which if specified, must be matched by peer", "", "string len 24"
+   "secret=abc123", "Optional identifier which, if specified, must be matched by peer", "", "string len 24"
    "zero-copy=yes", "Enable/disable zero-copy client mode. Only relevant to client, requires '--single-file-segments' eal argument", "no", "yes|no"
 
+**Access control**
+
+Any process able to connect to the socket of a server interface is able to
+reach its shared memory rings, so what restricts access to that socket is
+the security boundary.
+
+By default the socket is in the abstract namespace (``socket-abstract=yes``).
+An abstract socket has no filesystem entry.
+Use a network namespace to restrict access to such an interface.
+
+With ``socket-abstract=no`` the socket is a filesystem object and normal
+file permissions apply, together with the ``owner-uid`` and ``owner-gid``
+options.
+
+The ``secret`` option is *not* an access control mechanism.
+It only guards against connecting mismatched interfaces by mistake,
+for example where several interfaces share one socket.
+
 **Connection establishment**
 
 In order to create memif connection, two memif interfaces, each in separate
-- 
2.53.0

