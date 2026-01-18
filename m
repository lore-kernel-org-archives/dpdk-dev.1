Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ACCC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86617427DE;
	Sun, 18 Jan 2026 20:14:22 +0100 (CET)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id DCD23427CA
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:18 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so5542175a12.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763658;
 x=1769368458; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q49wA+VwnpdWyQ1WG1ozKxcFuIUvHqphroZNI+2NijU=;
 b=xhuVr2w9aCh7YlXfUwN1NpmLWAbu7E1LO7+sdRrB1ELnl9Av6Zyen/tZqB4oY0gC9f
 qUnkMc++Q8RlhPC4rJIRJD3eu8fHbU7LaI0BBYEIXG1vZTIY1iByt4TZNELgukYRPrHH
 Jx/j6tqOppqv/Zq5BDKx34MGIbsz5sfzdLgyFP+qErmBJwawUMsb4dxH9dpWQWUyCVH7
 ElZPUlfFji/7h3jNmT6kwjq4ylUFA/kCD1qIBf3H5uoYIMTDdROV04AG3aG7bz+Yr51l
 bFD4z9QbYMD8JxZGQRaKz4kQsMWDh6j0LvZXqXPPPVqSgmsMu9bme+XcT+hjcRawUCQX
 q2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763658; x=1769368458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q49wA+VwnpdWyQ1WG1ozKxcFuIUvHqphroZNI+2NijU=;
 b=W/5YOZUAn+J2yBYbPhfEeajjWsQJt1CeMP7JlTHc+V12cA/9My4B8ifE2rp8Tm23R3
 Jb1vsUxxB0MLmJbg0GFi+MfL1/uBQREJxmCBRvFnpVDsUy4AwWIOcGAlLjBKyyJiDUaD
 U4V/7gFRsaVbfBwedyPxcjWAEyM5m3v6X6Xwifz/D0hJ5JHeHnMQ+c7+Kf7qoeoEDqR7
 MKTZYkZtqYUoBtRKbO27IMLyXZtG4INmzM4le/al3VsaX1nJXVGGrAKwSvlDYKOCPFXJ
 XVJb+0EEYlb6ZjO4ttJw5c6Llto7q0+lZHFodnqMdqYCjin3Dc7WJJRQUll/XhwbE+qg
 oHOA==
X-Gm-Message-State: AOJu0YylJWYJB8ZUx1t9tKbatR0Qvstq1HVXOw/Z7AGCzH4yQrrDGoTF
 LktNFXiqWDCvjMTw0pHyUOgeIMYMTfMfK8AShFetQ3fYpIRJUrOvN0d8rZSQNEW5GZMEhcGhovl
 ryAzv
X-Gm-Gg: AY/fxX4pJVnJWNWONi66oMBVSq3yaP9iluXhtO27T3rHEhS2bwcOkW/y8oACCEuHXQQ
 8VQKHP6lLioTHlMRzewPM4Qy2fNJhnfd+klHLJG+GZMoLVL8C+zqC0wrUb5LldDIPSJQUPBI4jZ
 5UoX5zHjswdwUcipti8tWeIP19+18qbnEb9oQrraPp7XKLCRjmE//jFTIwjolKzfpCaFvWa9trV
 b529U87Md9cJmv5moXwcDo8oYzVCZqDdEtTB4r2aldxDBayKefQFi3eGEVuuEF3foAGLgkvOwaC
 gbLE1ljx79gxi6yJKcPRpcwxWX6VXY76YHxsKgvUqr40Gik52hvWVdqazf9Jc1GJ/c3SEbug1f1
 wN1tgN8fQzxybTHx+29R094L6BlBkJhSFVCDlS6LuLcg7UeOvYQBtTgEPhK6EgPrvc/kf/zhnX2
 YA5ruEfxPCqPr3Z3uBTQqtW6/a/6cLwsDrre5ThFvLqrURsp+1861+qoLmuasC
X-Received: by 2002:a17:906:9f92:b0:b87:6f7c:6094 with SMTP id
 a640c23a62f3a-b8796afd600mr754990466b.41.1768763658352; 
 Sun, 18 Jan 2026 11:14:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 32/54] doc: correct grammar in membership library guide
Date: Sun, 18 Jan 2026 11:10:35 -0800
Message-ID: <20260118191323.241013-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various grammar and style issues in the membership library
documentation:

- use "that" instead of "who" for applications
- fix subject-verb agreement in multiple places
- use consistent capitalization for Sub-figure references
- add missing articles before nouns
- correct grammar for element insertion description
- add missing relative pronouns for clarity
- fix "two time" to "two times the"
- correct function names to use rte_member_* pattern consistently
  (rte_membership_lookup_multi_bulk -> rte_member_lookup_multi_bulk,
   rte_membership_delete -> rte_member_delete)

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/member_lib.rst | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/doc/guides/prog_guide/member_lib.rst b/doc/guides/prog_guide/member_lib.rst
index d2f76de35c..fde7204ad4 100644
--- a/doc/guides/prog_guide/member_lib.rst
+++ b/doc/guides/prog_guide/member_lib.rst
@@ -31,7 +31,7 @@ is a fundamental data aggregation component that can be used in many network
 (and other) applications. It is a crucial structure to address performance and
 scalability issues of diverse network applications including overlay networks,
 data-centric networks, flow table summaries, network statistics and
-traffic monitoring. A set-summary is useful for applications who need to
+traffic monitoring. A set-summary is useful for applications that need to
 include a list of elements while a complete list requires too much space
 and/or too much processing cost. In these situations, the set-summary works as
 a lossy hash-based representation of a set of members. It can dramatically
@@ -47,7 +47,7 @@ probability.
 There are various usages for a Membership Library in a very
 large set of applications and workloads. Interested readers can refer to
 [Member-survey] for a survey of possible networking usages. The above figure
-provide a small set of examples of using the Membership Library:
+provides a small set of examples of using the Membership Library:
 
 * Sub-figure (a)
   depicts a distributed web cache architecture where a collection of proxies
@@ -66,7 +66,7 @@ provide a small set of examples of using the Membership Library:
   whether its id is a member of the set of visited nodes, and if it is, then a
   routing loop is detected.
 
-* Sub-Figure (c) presents another usage of the Membership
+* Sub-figure (c) presents another usage of the Membership
   Library to load-balance flows to worker threads with in-order guarantee where a
   set-summary is used to query if a packet belongs to an existing flow or a new
   flow. Packets belonging to a new flow are forwarded to the current least loaded
@@ -79,7 +79,7 @@ provide a small set of examples of using the Membership Library:
   element of a set against the other elements in a different set, a join is done
   on the summaries since they can efficiently encode members of a given set.
 
-Membership Library is a configurable library that is optimized to cover set
+The Membership Library is a configurable library that is optimized to cover set
 membership functionality for both a single set and multi-set scenarios. Two set-summary
 schemes are presented including (a) vector of Bloom Filters and (b) Hash-Table based
 set-summary schemes with and without false negative probability.
@@ -99,8 +99,8 @@ The BF is a method for representing a set of ``n`` elements (for example flow ke
 in network applications domain) to support membership queries. The idea of BF is
 to allocate a bit-vector ``v`` with ``m`` bits, which are initially all set to 0. Then
 it chooses ``k`` independent hash functions ``h1``, ``h2``, ... ``hk`` with hash values range from
-``0`` to ``m-1`` to perform hashing calculations on each element to be inserted. Every time when an
-element ``X`` being inserted into the set, the bits at positions ``h1(X)``, ``h2(X)``, ...
+``0`` to ``m-1`` to perform hashing calculations on each element to be inserted. Every time an
+element ``X`` is inserted into the set, the bits at positions ``h1(X)``, ``h2(X)``, ...
 ``hk(X)`` in ``v`` are set to 1 (any particular bit might be set to 1 multiple times
 for multiple different inserted elements). Given a query for any element ``Y``, the
 bits at positions ``h1(Y)``, ``h2(Y)``, ... ``hk(Y)`` are checked. If any of them is 0,
@@ -126,9 +126,9 @@ lookup with element comparison.
 
   Detecting Routing Loops Using BF
 
-BF is used for applications that need only one set, and the
+A BF is used for applications that need only one set, and the
 membership of elements is checked against the BF. The example discussed
-in the above figure is one example of potential applications that uses only one
+in the above figure is one example of potential applications that use only one
 set to capture the node IDs that have been visited so far by the packet. Each
 node will then check this embedded BF in the packet header for its own id, and
 if the BF indicates that the current node is definitely not in the set then a
@@ -280,7 +280,7 @@ The general input arguments used when creating the set-summary should include ``
 which is the name of the created set-summary, *type* which is one of the types
 supported by the library (e.g. ``RTE_MEMBER_TYPE_HT`` for HTSS or ``RTE_MEMBER_TYPE_VBF`` for vBF), and ``key_len``
 which is the length of the element/key. There are other parameters
-are only used for certain type of set-summary, or which have a slightly different meaning for different types of set-summary.
+that are only used for a certain type of set-summary, or that have a slightly different meaning for different types of set-summary.
 For example, ``num_keys`` parameter means the maximum number of entries for Hash table based set-summary.
 However, for bloom filter, this value means the expected number of keys that could be
 inserted into the bloom filter(s). The value is used to calculate the size of each
@@ -293,7 +293,7 @@ set-summary. For HTSS, another parameter ``is_cache`` is used to indicate
 if this set-summary is a cache (i.e. with false negative probability) or not.
 For vBF, extra parameters are needed. For example, ``num_set`` is the number of
 sets needed to initialize the vector bloom filters. This number is equal to the
-number of bloom filters will be created.
+number of bloom filters that will be created.
 ``false_pos_rate`` is the false positive rate. num_keys and false_pos_rate will be used to determine
 the number of hash functions and the bloom filter size.
 
@@ -346,11 +346,11 @@ element/key that needs to be looked up, ``max_match_per_key`` which is to indica
 the user expects to find for each key, and ``set_id`` which is used to return all
 target set ids where the key has matched, if any. The ``set_id`` array should be sized
 according to ``max_match_per_key``. For vBF, the maximum number of matches per key is equal
-to the number of sets. For HTSS, the maximum number of matches per key is equal to two time
+to the number of sets. For HTSS, the maximum number of matches per key is equal to two times the
 entry count per bucket. ``max_match_per_key`` should be equal or smaller than the maximum number of
 possible matches.
 
-The ``rte_membership_lookup_multi_bulk()`` function looks up a bulk of keys/elements in the
+The ``rte_member_lookup_multi_bulk()`` function looks up a bulk of keys/elements in the
 set-summary structure for multiple matches, each key lookup returns ALL the matches (possibly more
 than one) found for this key when it is matched against all target sets (cache mode HTSS
 matches at most one target set). The
@@ -370,7 +370,7 @@ possible matches, similar to ``rte_member_lookup_multi``.
 Set-summary Element Delete
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The ``rte_membership_delete()`` function deletes an element/key from a set-summary structure, if it fails
+The ``rte_member_delete()`` function deletes an element/key from a set-summary structure, if it fails
 an error is returned. The input arguments should include ``key`` which is a pointer to the
 element/key that needs to be deleted from the set-summary, and ``set_id``
 which is the set id associated with the key to delete. It is worth noting that current
-- 
2.51.0

