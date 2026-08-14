Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA676C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:19:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC3494013F;
	Fri, 14 Aug 2026 17:19:12 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id AF2E4400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:19:11 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2caced6038eso13380285ad.0
 for <dev@dpdk.org>; Fri, 14 Aug 2026 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786720751;
 x=1787325551; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nxuvu54pD2EfTvqWng4Y7lCY0YrZcXjwXGjCrsQICGs=;
 b=qArwkzmBziMBG2jm5zhJSfzeqY679Ff9yKpd75PnqXeO9TmKKu+79BsY1MdBDJQtzV
 FuUrwZQuRIJMFiJjpFXTsGwbJ6NxNTqUcdmUFiaM+/X1lz5DwrgbvkQKDD03XafFTVSH
 eJtDolG0OM6NrDHbbyQDZdhUYqckU3LgS6N4h6W7ceXsFY0mduGW3ULt6liKwLN3hc98
 nwjDmnvgi9/2my0IjtqqmdGB6yWTuTzlQPLnhRGd36jOqzm/HBtkEq5755KDGwPlSMH+
 p3excqbHg+DGiSmwdRncSPQ2BYO36W0a+pqtRyvWGWLo3/NMH/tFEVe6TA3V4NVZvbEl
 Of1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786720751; x=1787325551;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nxuvu54pD2EfTvqWng4Y7lCY0YrZcXjwXGjCrsQICGs=;
 b=mFDtT4xMPRtJ8KytoVMAXkitKlw9PoElUV3gENY4BQUgwtZHh1FctPVRhu7o5dcg5x
 Ikl/mrjD9qIRqWECdsetRoNEOWLPwX9rUQ6/bL623EtbPoAQN91Nb9njEtK7hTRy3SPG
 4ZOGWoyfoUh1eF0jY7SJTHpb5RpztDT9/yXDDy/X9myLr8+UWvtqU82Vqp5Qi1WazWJ5
 VAc2Ysc6NIz8FLQc04xT6STSwHD4Rcic/J7RfvllJqcxusdrj4XB/0at6YJSEwm/+Nyg
 2JwBEZFHP7JwVzTI43lFxhp0jebc2l2ky+N5kOgnU1PKLNcHqyq9Hr8sK+oRn6RbpMV3
 1y9Q==
X-Gm-Message-State: AOJu0YymZ9QhUtwYPFkBo/eODh8P25K9ytAZI3Iwus50uAKIMTdvlfHN
 Orjb1QY480qzs2xbCfelxi5WWNjV8I8BefKElvLXFYwQP2xFQHotO7Ky3WLSl3KD1s4=
X-Gm-Gg: AR+sD10LGH2+g1MkW3igWojtG8DcddDPQaENk1PdXuRYFyD3hjbr9C9nqOtta5C2gad
 x24/6HxpmBdPUMTV+RMA/0/2QKU9wuVtP+EffQ8ThB3pHPn1K6X8dve6QP+ecwFxxowRhWT0hDM
 kSGq8/4sC9PHhTT1txH1ObpSFzTht1ftyy3T85raDm8fvpMZNhBsoJy4x/XLPr4hx17mmHk8bRM
 9dHRaJpykXjwXhfj3HQNWUKTFTAA/Gi+AhYNiTtEX2VEr8/C/R2lXF0jd/g+5ACb06gOc2Q1HN9
 fgrSd81zGgAKVelLsdGCkIBLQZv4shFTXEL+nE5KWCJIVf8W/t/LJAfP4R/QiTH5YA1EIjdxrmX
 i9LlIKdZ7UIhWf6afrZOIldk8eN+LIxXzaRWdYIZziewelocYwZ2UOf8bU0GtnGzBi+kOkb2ydS
 ECBy3Oo1OOr7Dt5fDOVBP6P2pPPAL7vOBZRuErb2Qof2gOT9RniyPPqKK4P4ibVDm5Co51IOjP/
 X97+hDW/a52ks2fCUpU3tcNF27E1A==
X-Received: by 2002:a17:902:f64e:b0:2cf:70d2:da7c with SMTP id
 d9443c01a7336-2d37f77fdfemr165440955ad.12.1786720750443; 
 Fri, 14 Aug 2026 08:19:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d5bdc5c4sm5926443eec.5.2026.08.14.08.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 08:19:10 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:19:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, "Wathsala Vithanage"
 <wathsala.vithanage@arm.com>
Subject: Re: [RFC] increase name sizes and reorder structures
Message-ID: <20260814081900.296bd8ca@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659E4@smartserver.smartshare.dk>
References: <20260813171418.568620-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659E4@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 14 Aug 2026 14:12:11 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 13 August 2026 19.13
> >=20
> > This is a trial balloon to see what Morten's suggestion would
> > look like.
> >=20
> > Increase memzone name size to 64 and reorder structure
> > to keep it cache friendly.  Move the zone name to the end of
> > struct rte_memzone and order the remaining members by size.
> > The structure is then naturally aligned
> > with no internal padding on both 64-bit and 32-bit targets, so the
> > __rte_packed_begin/end markers can be removed.
> >=20
> > With memzone size of 64 but don't need all that for stack names.
> > Increase the size to 32 which adds some space without impacting
> > cache layout.
> >=20
> > The memzone increase to 64 allows ring names to grow to 32 characters.
> > Don't need to go larger which could cause cache changes when ring is
> > embedded in structures.
> >=20
> > Bugzilla ID: 1984
> >=20
> > Reported-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > --- =20
>=20
> Not as much as I hoped for, but non-intrusive.
> A small improvement is still an improvement!
>=20
> Typo in the release notes:
> "incre   " -> "increased"
>=20
> Reviewed-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20

Only took baby first steps here. I asked AI for analysis on going further.

On the question of going bigger than 64/32, here is what I found looking
at the actual constraints in the tree.

The memzone derivation is the artificial coupling
-------------------------------------------------

rte_ring_lookup(), rte_mempool_lookup() and rte_stack_lookup() all walk
their tailq and strncmp() against the object's own name field.  None of
them go through rte_memzone_lookup().  So RTE_MEMZONE_NAMESIZE does not
bound anything functional; it only bounds the derived string "RG_%s"
used to reserve the backing memzone, which is a debug label plus a
uniqueness token.

If the derived name became something like

	"RG_%.16s_%08x"   /* truncated prefix + hash of full name */

then RTE_RING_NAMESIZE, RTE_STACK_NAMESIZE and RTE_MEMPOOL_NAMESIZE are
decoupled from memzone entirely and both static_asserts go away.  Each
library's limit then becomes a storage-cost decision rather than an
inherited one.

Two things need handling:

- Hash collisions make rte_memzone_reserve() fail with EEXIST, so the
  reserve path needs a retry with a disambiguating counter.
- memzone dumps and telemetry output get less greppable.  Keeping a
  truncated prefix of the real name mostly covers this.

Self-relative offset instead of a flexible array
------------------------------------------------

Two of the blockers (embedded structures, structures that already have a
flexible array) exist only because C requires a flexible array to be
last.  An offset has no position requirement:

	uint32_t name_off;  /* byte offset from struct start to name */

This works when the struct is embedded (rte_event_ring wraps rte_ring),
coexists with an existing trailing flexible array (rte_node_register is
the case: name[RTE_NODE_NAMESIZE] plus next_nodes[]), and keeps the
record fixed size so fbarray stride is preserved.

A plain const char * would probably also work since rte_mempool already
stores a const struct rte_memzone *mz into shared memory, but an offset
avoids depending on identical secondary process mappings.

Cost is source churn: every mz->name becomes rte_memzone_name(mz).  Only
28 sites in tree, but out-of-tree consumers exist, so this wants a
deprecation notice ahead of an ABI break release.

Side table (least disruptive)
-----------------------------

Keep the inline char name[N] untouched for compatibility and add a
shared registry keyed by object index holding the full name only when it
exceeds N.  Lookup checks inline first, then the registry.

No stride change, no ABI change, no flexible arrays, unlimited length.
The tradeoff is that mz->name and r->name stay truncated for anything
reading them directly, so it fixes lookup but not display.

Numbers on ring growth
----------------------

Measured on x86-64:

	RTE_RING_NAMESIZE=3D32   sizeof(struct rte_ring)=3D384  prod at 128
	RTE_RING_NAMESIZE=3D61   sizeof(struct rte_ring)=3D448  prod at 192

One extra cache line per ring plus a shifted hot region, inherited by
rte_event_ring.  That is the concrete argument for capping ring names at
32 rather than following memzone to 64.

memzone is the opposite case: 104 bytes x 2560 default entries is about
266KB, so a larger fixed name there is nearly free.  The fbarray stride
constraint blocks variable-length names, not bigger ones.

